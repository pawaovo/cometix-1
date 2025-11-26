
import React, { useState, useEffect, useRef } from 'react';
import { Message, View, QuickPhrase } from '../types';
import InputBar from './InputBar';
import { sendMessageToGemini } from '../services/geminiService';
import ReactMarkdown from 'react-markdown';

interface ChatScreenProps {
  onMenuClick: () => void;
  onNavigate: (view: View) => void;
  quickPhrases: QuickPhrase[];
}

const ChatScreen: React.FC<ChatScreenProps> = ({ onMenuClick, quickPhrases }) => {
  const [messages, setMessages] = useState<Message[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const scrollEndRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    scrollEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const handleSend = async (text: string) => {
    const userMessage: Message = { role: 'user', text };
    setMessages(prev => [...prev, userMessage]);
    setIsLoading(true);

    let assistantMessageText = '';
    const tempAssistantMessageId = Date.now();
    
    // Add placeholder assistant message
    setMessages(prev => [...prev, { role: 'model', text: '' }]);

    await sendMessageToGemini(messages, text, (chunk) => {
      assistantMessageText += chunk;
      setMessages(prev => {
        const newHistory = [...prev];
        // Update the last message (which is the assistant's)
        const lastMsg = newHistory[newHistory.length - 1];
        if (lastMsg.role === 'model') {
            lastMsg.text = assistantMessageText;
        }
        return newHistory;
      });
    });

    setIsLoading(false);
  };

  return (
    <div className="flex flex-col h-full bg-background-light dark:bg-background-dark animate-fade-in relative">
      {/* Header */}
      <header className="flex items-center justify-between p-4 bg-background-light/90 dark:bg-background-dark/90 backdrop-blur-md sticky top-0 z-10">
        <button onClick={onMenuClick} className="text-gray-800 dark:text-gray-200 p-1 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800">
          <span className="material-symbols-outlined text-3xl">menu</span>
        </button>
        <h1 className="text-xl font-medium text-gray-900 dark:text-gray-100">
          {messages.length === 0 ? "新对话" : "Gemini 2.5"}
        </h1>
        <div className="flex items-center space-x-2">
          <button className="text-gray-800 dark:text-gray-200 p-1 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800">
            <span className="material-symbols-outlined text-3xl">map</span>
          </button>
          <button 
            className="text-gray-800 dark:text-gray-200 p-1 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800"
            onClick={() => setMessages([])}
          >
            <span className="material-symbols-outlined text-3xl">add_circle</span>
          </button>
        </div>
      </header>

      {/* Main Chat Area */}
      <main className="flex-grow overflow-y-auto px-4 py-2 no-scrollbar">
        {messages.length === 0 ? (
          <div className="flex flex-col items-center justify-center h-full text-center text-gray-400 opacity-60">
             <div className="w-24 h-24 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center mb-6">
                <span className="material-symbols-outlined text-5xl text-gray-300 dark:text-gray-600">smart_toy</span>
             </div>
             <p className="text-lg font-medium">开始一个新的对话</p>
          </div>
        ) : (
          <div className="space-y-6 pb-4">
            {messages.map((msg, index) => (
              <div 
                key={index} 
                className={`flex w-full ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}
              >
                <div 
                  className={`max-w-[85%] rounded-2xl px-5 py-3.5 shadow-sm text-base leading-relaxed ${
                    msg.role === 'user' 
                      ? 'bg-gray-100 dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-br-none' 
                      : 'bg-transparent text-gray-800 dark:text-gray-200 -ml-2'
                  }`}
                >
                    {msg.role === 'model' && msg.text === '' ? (
                         <div className="flex space-x-1 items-center h-6">
                            <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '0ms' }}></div>
                            <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '150ms' }}></div>
                            <div className="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style={{ animationDelay: '300ms' }}></div>
                         </div>
                    ) : (
                        <div className="prose dark:prose-invert prose-p:my-1 prose-pre:bg-gray-800 prose-pre:rounded-xl prose-pre:p-4 max-w-none">
                            <ReactMarkdown>{msg.text}</ReactMarkdown>
                        </div>
                    )}
                </div>
              </div>
            ))}
            <div ref={scrollEndRef} />
          </div>
        )}
      </main>

      {/* Input Area */}
      <InputBar onSend={handleSend} disabled={isLoading} quickPhrases={quickPhrases} />
    </div>
  );
};

export default ChatScreen;
