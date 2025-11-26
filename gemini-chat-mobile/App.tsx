
import React, { useState } from 'react';
import ChatScreen from './components/ChatScreen';
import Sidebar from './components/Sidebar';
import SettingsPage from './components/SettingsPage';
import { View, QuickPhrase } from './types';

const initialQuickPhrases: QuickPhrase[] = [
  { id: '1', phrase: '请帮我总结一下这段内容', shortcut: '总结' },
  { id: '2', phrase: '请把这段内容翻译成英文', shortcut: '翻译' },
  { id: '3', phrase: '请解释一下这段代码', shortcut: '解释' },
  { id: '4', phrase: '湖南省常德市', shortcut: '地址' },
];

function App() {
  const [currentView, setCurrentView] = useState<View>('home');
  const [isSidebarOpen, setIsSidebarOpen] = useState(false);
  const [quickPhrases, setQuickPhrases] = useState<QuickPhrase[]>(initialQuickPhrases);

  const handleNavigate = (view: View) => {
    setCurrentView(view);
    setIsSidebarOpen(false);
  };

  return (
    <div className="relative w-full h-dvh max-w-md mx-auto bg-background-light dark:bg-background-dark shadow-2xl overflow-hidden md:rounded-[3rem] md:h-[95vh] md:my-[2.5vh] md:border-[8px] md:border-gray-800">
      {/* 
         On Desktop, we wrap it in a "Phone" frame (max-w-md, rounded corners, border).
         On Mobile, it takes full viewport (w-full h-dvh).
      */}

      {/* Sidebar - Always mounted, controls its own visibility via CSS transform */}
      <Sidebar 
        isOpen={isSidebarOpen} 
        onClose={() => setIsSidebarOpen(false)} 
        onNavigate={handleNavigate}
      />

      {/* Main Content Area */}
      <div className={`h-full transition-transform duration-300 ease-in-out ${isSidebarOpen ? 'translate-x-[80%] scale-[0.95] rounded-3xl overflow-hidden shadow-2xl opacity-80' : ''}`}>
        {currentView === 'home' ? (
          <ChatScreen 
            onMenuClick={() => setIsSidebarOpen(true)} 
            onNavigate={handleNavigate}
            quickPhrases={quickPhrases}
          />
        ) : (
          <SettingsPage 
            onBack={() => setCurrentView('home')} 
            quickPhrases={quickPhrases}
            onUpdateQuickPhrases={setQuickPhrases}
          />
        )}
      </div>
    </div>
  );
}

export default App;
