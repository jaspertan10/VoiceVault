//
//  ContentView.swift
//  VoiceVault
//
//  Created by Jasper Tan on 4/1/25.
//

import SwiftUI
import TranscriptionKit

class History: Identifiable {
    var id: UUID
    var date: Date
    var transcript: String?
    
    init(id: UUID = UUID(), date: Date = Date(), transcript: String? = nil) {
        self.id = id
        self.date = date
        self.transcript = transcript
    }
}

struct RecordingIndicatorView: View {
    let isRecording: Bool
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack {
                    Text("Recording Status")
                        .font(.title)
                    
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                }

            }
    }
}

struct ContentView: View {
    
    @State var speechRecognizer = SpeechRecognizer()
    @State private var isRecording: Bool = false
    
    @State private var history = History()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                
                if let transcript = history.transcript {
                    Text(transcript)
                }
                
                Button("Start") {
                    speechRecognizer.startTranscribing()
                    isRecording = true
                }
                
                Button("Stop") {
                    speechRecognizer.stopTranscribing()
                    isRecording = false
                    
                    history.transcript = speechRecognizer.transcript
                }
                
                RecordingIndicatorView(isRecording: isRecording)
            }
            .navigationTitle("VoiceVault")
            .onAppear {
                speechRecognizer.resetTranscript()
            }
        }
    }
}

#Preview {
    ContentView()
}
