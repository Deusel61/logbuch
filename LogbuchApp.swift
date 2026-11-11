import SwiftUI
import WebKit

/// Logbuch – One-Piece-Folgen-Tracker.
/// Die Oberfläche liegt als HTML im App-Bundle (Ordner „Web“) und läuft komplett offline.
/// Der Fortschritt wird als JSON-Datei im App-Speicher des iPhones abgelegt.
@main
struct LogbuchApp: App {
    var body: some Scene {
        WindowGroup {
            LogbuchWebView()
                .ignoresSafeArea()
                .background(Color(red: 0.04, green: 0.08, blue: 0.11))
        }
    }
}

/// Speichert den Fortschritt dauerhaft in „Application Support/logbuch.json“.
enum ProgressStore {
    static var fileURL: URL {
        let dir = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        return dir.appendingPathComponent("logbuch.json")
    }

    static func load() -> String {
        (try? String(contentsOf: fileURL, encoding: .utf8)) ?? "{}"
    }

    static func save(_ json: String) {
        let dir = fileURL.deletingLastPathComponent()
        try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        try? json.write(to: fileURL, atomically: true, encoding: .utf8)
    }
}

struct LogbuchWebView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let controller = config.userContentController

        // Gespeicherten Stand vor dem Laden der Seite bereitstellen.
        let state = ProgressStore.load()
        let literal: String
        if let data = try? JSONSerialization.data(withJSONObject: [state]),
           let wrapped = String(data: data, encoding: .utf8) {
            literal = wrapped + "[0]"
        } else {
            literal = "\"{}\""
        }
        let script = WKUserScript(
            source: "window.__NATIVE_STATE__ = \(literal);",
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
        controller.addUserScript(script)
        controller.add(context.coordinator, name: "save")

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.allowsBackForwardNavigationGestures = false

        if let index = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "Web") {
            webView.loadFileURL(index, allowingReadAccessTo: index.deletingLastPathComponent())
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    final class Coordinator: NSObject, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
        // Die Seite meldet jede Änderung als JSON-Text.
        func userContentController(_ userContentController: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            if let json = message.body as? String {
                ProgressStore.save(json)
            }
        }

        // Links ins Internet (z. B. TVmaze) in Safari öffnen statt in der App.
        func webView(_ webView: WKWebView,
                     decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            if let url = navigationAction.request.url,
               let scheme = url.scheme?.lowercased(),
               scheme == "http" || scheme == "https" {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
        }

        // Links mit target="_blank"
        func webView(_ webView: WKWebView,
                     createWebViewWith configuration: WKWebViewConfiguration,
                     for navigationAction: WKNavigationAction,
                     windowFeatures: WKWindowFeatures) -> WKWebView? {
            if let url = navigationAction.request.url {
                UIApplication.shared.open(url)
            }
            return nil
        }
    }
}
