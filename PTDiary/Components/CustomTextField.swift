//
//  CustomTextField.swift
//  PTDiary
//
//  Created by sseungwonnn on 6/17/24.
//

import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    @Binding var text: String
    var onCommit: () -> Void

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CustomTextField

        init(_ parent: CustomTextField) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.updateTextView(textView)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == " " {
                parent.onCommit()
            }
            return true
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = UIFont.systemFont(ofSize: 17)
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        updateTextView(uiView)
    }

    func updateTextView(_ textView: UITextView) {
        let attributedText = NSMutableAttributedString(string: textView.text)
        let words = textView.text.split(separator: " ")
        for word in words {
            if word.hasPrefix("#") {
                let range = (textView.text as NSString).range(of: String(word))
                attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
            }
        }
        textView.attributedText = attributedText
    }
}
