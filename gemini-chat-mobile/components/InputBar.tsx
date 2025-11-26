
import React, { useRef, useState, useEffect } from 'react';
import { QuickPhrase } from '../types';

interface InputBarProps {
  onSend: (message: string) => void;
  disabled: boolean;
  quickPhrases?: QuickPhrase[];
}

type ActiveTool = 'history' | 'model' | 'mcp' | 'quick' | null;

const InputBar: React.FC<InputBarProps> = ({ onSend, disabled, quickPhrases = [] }) => {
  const [input, setInput] = useState('');
  const [suggestion, setSuggestion] = useState<QuickPhrase | null>(null);
  const [isMenuExpanded, setIsMenuExpanded] = useState(false);
  const [activeTool, setActiveTool] = useState<ActiveTool>(null);
  const fileInputRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (activeTool === 'quick') return; // Don't override if manually showing list

    if (!input.trim()) {
      setSuggestion(null);
      return;
    }

    // Check for exact match with shortcuts
    const match = quickPhrases.find(qp => qp.shortcut === input);
    if (match) {
      setSuggestion(match);
    } else {
      setSuggestion(null);
    }
  }, [input, quickPhrases, activeTool]);

  const handleSubmit = (e?: React.FormEvent) => {
    e?.preventDefault();
    if (!input.trim() || disabled) return;
    onSend(input);
    setInput('');
    setSuggestion(null);
    setActiveTool(null);
  };

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      handleSubmit();
    }
  };

  const applySuggestion = (phrase: QuickPhrase) => {
    setInput(phrase.phrase);
    setSuggestion(null);
    setActiveTool(null);
  };

  const toggleTool = (tool: ActiveTool) => {
      if (activeTool === tool) {
          setActiveTool(null);
      } else {
          setActiveTool(tool);
          setIsMenuExpanded(false); // Close other menu if open
      }
  };

  const handleCameraClick = () => {
    console.log("Camera clicked");
    setIsMenuExpanded(false);
  };

  const handleGalleryClick = () => {
    fileInputRef.current?.click();
    setIsMenuExpanded(false);
  };

  const handleFileClick = () => {
    console.log("File Manager clicked");
    setIsMenuExpanded(false);
  };

  // Mock data for other tools
  const historyItems = ['上次对话', '关于 React Hooks', '翻译任务', '代码调试'];
  const modelItems = ['Gemini 2.5 Flash', 'Gemini 1.5 Pro', 'GPT-4o', 'Claude 3.5 Sonnet'];
  const mcpItems = ['fetch_html', 'fetch_json', 'web_search', 'code_interpreter'];

  return (
    <>
      {/* Backdrop for collapsing menu or tools */}
      {(isMenuExpanded || activeTool) && (
        <div 
          className="fixed inset-0 z-10" 
          onClick={() => {
            setIsMenuExpanded(false);
            setActiveTool(null);
          }}
        />
      )}

      <footer className="p-3 bg-background-light dark:bg-background-dark pb-6 relative z-20 flex flex-col gap-1">
        
        {/* Tool Popups (History, Model, MCP, QuickPhrase) */}
        {(activeTool || suggestion) && (
          <div className="absolute bottom-full mb-2 left-4 right-4 z-20 animate-fade-in-up flex flex-wrap gap-2 justify-start bg-transparent pointer-events-none">
             <div className="pointer-events-auto bg-card-light dark:bg-card-dark p-2 rounded-2xl shadow-xl border border-gray-100 dark:border-gray-800 flex flex-col items-start gap-1 max-h-60 overflow-y-auto w-full">
                
                {/* History Content */}
                {activeTool === 'history' && (
                    <>
                        <div className="px-4 py-2 text-xs font-bold text-gray-500 uppercase">最近对话</div>
                        {historyItems.map((item, idx) => (
                            <button key={idx} className="flex w-full items-center space-x-3 hover:bg-gray-100 dark:hover:bg-gray-800 px-4 py-2 rounded-xl transition-colors text-left">
                                <span className="material-symbols-outlined text-sm text-gray-500">chat_bubble_outline</span>
                                <span className="text-sm font-medium text-gray-900 dark:text-gray-100">{item}</span>
                            </button>
                        ))}
                    </>
                )}

                {/* Model Content */}
                {activeTool === 'model' && (
                    <>
                        <div className="px-4 py-2 text-xs font-bold text-gray-500 uppercase">切换模型</div>
                        {modelItems.map((item, idx) => (
                            <button key={idx} className="flex w-full items-center space-x-3 hover:bg-gray-100 dark:hover:bg-gray-800 px-4 py-2 rounded-xl transition-colors text-left">
                                <span className="material-symbols-outlined text-sm text-blue-500">smart_toy</span>
                                <span className="text-sm font-medium text-gray-900 dark:text-gray-100">{item}</span>
                                {idx === 0 && <span className="material-symbols-outlined text-sm text-blue-500 ml-auto">check</span>}
                            </button>
                        ))}
                    </>
                )}

                {/* MCP Content */}
                {activeTool === 'mcp' && (
                    <>
                        <div className="px-4 py-2 text-xs font-bold text-gray-500 uppercase">MCP 工具</div>
                        {mcpItems.map((item, idx) => (
                            <button key={idx} className="flex w-full items-center space-x-3 hover:bg-gray-100 dark:hover:bg-gray-800 px-4 py-2 rounded-xl transition-colors text-left">
                                <span className="material-symbols-outlined text-sm text-orange-500">construction</span>
                                <span className="text-sm font-medium text-gray-900 dark:text-gray-100">{item}</span>
                                <div className="ml-auto w-2 h-2 rounded-full bg-green-500"></div>
                            </button>
                        ))}
                    </>
                )}

                {/* Quick Phrase Content (Manual Toggle) */}
                {activeTool === 'quick' && (
                     quickPhrases.length > 0 ? quickPhrases.map(qp => (
                        <button 
                            key={qp.id}
                            onClick={() => applySuggestion(qp)}
                            className="flex w-full items-center space-x-2 hover:bg-gray-100 dark:hover:bg-gray-800 px-4 py-2 rounded-xl transition-colors text-left"
                        >
                            <span className="material-symbols-outlined text-sm text-[#8B5E3C]">bolt</span>
                            <div className="flex flex-col">
                                <span className="text-sm font-medium text-gray-900 dark:text-gray-100">{qp.phrase}</span>
                                <span className="text-[10px] text-gray-500 font-mono">/{qp.shortcut}</span>
                            </div>
                        </button>
                     )) : <div className="p-4 text-sm text-gray-500 text-center w-full">暂无快捷短语</div>
                )}

                {/* Auto Suggestion Content (Shortcut Match) */}
                {!activeTool && suggestion && (
                    <button 
                        onClick={() => applySuggestion(suggestion)}
                        className="flex items-center space-x-2 bg-[#8B5E3C] text-white px-4 py-2 rounded-xl shadow-lg hover:bg-[#7A5235] transition-colors"
                    >
                        <span className="material-symbols-outlined text-sm">bolt</span>
                        <span className="text-sm font-medium truncate max-w-[200px]">{suggestion.phrase}</span>
                    </button>
                )}
             </div>
          </div>
        )}

        {/* Top Icons Row (History, Model, MCP, QuickPhrase) */}
        <div className="flex items-center px-2 space-x-6 overflow-x-auto no-scrollbar py-2">
             {/* History */}
             <button 
                onClick={() => toggleTool('history')}
                className={`transition-colors p-1 ${activeTool === 'history' ? 'text-gray-900 dark:text-gray-100' : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200'}`}
                title="上次对话"
             >
                <span className="material-symbols-outlined text-[26px]">history</span>
            </button>

            {/* Model */}
            <button 
                onClick={() => toggleTool('model')}
                className={`transition-colors p-1 ${activeTool === 'model' ? 'text-gray-900 dark:text-gray-100' : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200'}`}
                title="模型"
            >
                <span className="material-symbols-outlined text-[26px]">smart_toy</span>
            </button>

             {/* MCP Tool */}
             <button 
                onClick={() => toggleTool('mcp')}
                className={`transition-colors p-1 ${activeTool === 'mcp' ? 'text-gray-900 dark:text-gray-100' : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200'}`}
                title="MCP 工具"
             >
                <span className="material-symbols-outlined text-[26px]">construction</span>
             </button>

             {/* Quick Phrase */}
             <button 
                onClick={() => toggleTool('quick')}
                className={`transition-colors p-1 ${activeTool === 'quick' ? 'text-gray-900 dark:text-gray-100' : 'text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200'}`}
                title="快捷短语"
             >
                <span className="material-symbols-outlined text-[26px]">bolt</span>
             </button>
        </div>

        {/* Bottom Input Bar */}
        <div className="flex items-center bg-gray-100 dark:bg-gray-800 rounded-[1.5rem] p-1.5 border border-gray-200 dark:border-gray-700 shadow-sm relative">
          
          {/* Left Action Group */}
          <div className="flex items-center space-x-1 mr-1">
             {/* Expandable Media Menu */}
             <div className={`flex items-center transition-all duration-300 ease-in-out overflow-hidden ${isMenuExpanded ? 'bg-gray-200 dark:bg-gray-700 rounded-full pr-1' : ''}`}>
                 {!isMenuExpanded ? (
                     <button 
                        onClick={() => {
                            setIsMenuExpanded(true);
                            setActiveTool(null);
                        }}
                        className="p-2 text-gray-500 dark:text-gray-400 hover:text-gray-700 dark:hover:text-gray-200 transition-colors"
                     >
                        <span className="material-symbols-outlined text-2xl">add_circle</span>
                     </button>
                 ) : (
                     <div className="flex items-center animate-fade-in">
                        <button onClick={handleCameraClick} className="p-2 text-gray-600 dark:text-gray-300 hover:text-[#8B5E3C] transition-colors" title="拍照">
                            <span className="material-symbols-outlined text-xl">camera_alt</span>
                        </button>
                        <button onClick={handleGalleryClick} className="p-2 text-gray-600 dark:text-gray-300 hover:text-[#8B5E3C] transition-colors" title="相册">
                             <span className="material-symbols-outlined text-xl">image</span>
                        </button>
                        <button onClick={handleFileClick} className="p-2 text-gray-600 dark:text-gray-300 hover:text-[#8B5E3C] transition-colors" title="文件">
                             <span className="material-symbols-outlined text-xl">folder</span>
                        </button>
                     </div>
                 )}
             </div>
          </div>
          
          {/* Text Input */}
          <input 
            className="flex-grow bg-transparent border-none focus:ring-0 text-gray-700 dark:text-gray-200 placeholder-gray-400 dark:placeholder-gray-500 mx-1 text-base py-2 min-w-0 caret-blue-500" 
            placeholder="发送消息" 
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyDown={handleKeyDown}
            onFocus={() => {
                // Focusing the input should close any active tool popups to allow typing
                if (activeTool) setActiveTool(null);
                if (isMenuExpanded) setIsMenuExpanded(false);
            }}
            disabled={disabled}
          />
          
          {/* Hidden File Input (triggered by Gallery button) */}
          <input 
            type="file" 
            ref={fileInputRef} 
            className="hidden" 
            onChange={(e) => console.log(e.target.files)} 
          />
          
          {/* Send Button */}
          <button 
            onClick={() => handleSubmit()}
            disabled={!input.trim() || disabled}
            className={`w-8 h-8 flex-shrink-0 flex items-center justify-center rounded-full transition-all duration-200 ml-1 ${
              input.trim() 
                ? 'bg-black dark:bg-white text-white dark:text-black shadow-md' 
                : 'bg-gray-200 dark:bg-gray-600 text-gray-600 dark:text-gray-300'
            }`}
          >
            <span className="material-symbols-outlined text-lg">arrow_upward</span>
          </button>
        </div>
        
        {/* Home Indicator line (iOS style) */}
        <div className="w-32 h-1.5 bg-gray-300 dark:bg-gray-700 rounded-full mx-auto mt-4"></div>
      </footer>
    </>
  );
};

export default InputBar;
