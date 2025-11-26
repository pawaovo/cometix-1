
import React, { useState } from 'react';
import { SettingsSection, Assistant, Provider, SearchProvider, MCPServer, MCPTool, QuickPhrase, SettingsPageProps } from '../types';

type SubPage = 
  | 'display' 
  | 'assistant' 
  | 'default_model' 
  | 'providers' 
  | 'search' 
  | 'mcp' 
  | 'quick_phrase' 
  | 'proxy' 
  | 'backup'
  | 'chat_storage'
  | 'about'
  | 'docs'
  | 'sponsor';

type ModelType = 'chat' | 'summary' | 'translation' | 'ocr';

interface ModelConfig {
    id: string;
    name: string;
    prompt: string;
}

// --- Reusable UI Components ---

const Header = ({ title, onBack, actionIcon, onAction, secondaryActionIcon, onSecondaryAction }: { title: string, onBack: () => void, actionIcon?: string, onAction?: () => void, secondaryActionIcon?: string, onSecondaryAction?: () => void }) => (
  <header className="flex items-center justify-between px-4 py-4 bg-background-light dark:bg-background-dark border-b border-gray-100 dark:border-gray-800 shrink-0 sticky top-0 z-10">
    <div className="flex items-center">
      <button onClick={onBack} className="p-2 -ml-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
        <span className="material-symbols-outlined text-2xl text-gray-800 dark:text-gray-200">arrow_back</span>
      </button>
      <h1 className="ml-2 text-xl font-medium text-gray-900 dark:text-gray-100">{title}</h1>
    </div>
    <div className="flex items-center space-x-1">
        {secondaryActionIcon && (
        <button onClick={onSecondaryAction} className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-800 dark:text-gray-200 transition-colors">
            <span className="material-symbols-outlined text-2xl">{secondaryActionIcon}</span>
        </button>
        )}
        {actionIcon && (
        <button onClick={onAction} className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-800 dark:text-gray-200 transition-colors">
            <span className="material-symbols-outlined text-2xl">{actionIcon}</span>
        </button>
        )}
    </div>
  </header>
);

const SelectionItem = ({ 
  label, 
  selected, 
  onClick, 
  subtitle, 
  icon,
  rightElement
}: { 
  label: string, 
  selected?: boolean, 
  onClick?: () => void, 
  subtitle?: string,
  icon?: string,
  rightElement?: React.ReactNode
}) => (
  <button 
    onClick={onClick}
    className="flex w-full items-center justify-between p-4 text-left transition-colors hover:bg-black/5 dark:hover:bg-white/5 active:bg-black/10 dark:active:bg-white/10 outline-none"
  >
    <div className="flex items-center overflow-hidden">
      {icon && <span className="material-symbols-outlined text-text-secondary-light dark:text-text-secondary-dark mr-4 flex-shrink-0">{icon}</span>}
      <div className="flex-1 min-w-0">
        <div className="text-base font-medium truncate text-gray-900 dark:text-gray-100">{label}</div>
        {subtitle && <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark truncate">{subtitle}</div>}
      </div>
    </div>
    {rightElement ? rightElement : (selected && <span className="material-symbols-outlined text-black dark:text-white ml-4 flex-shrink-0">check</span>)}
  </button>
);

const ToggleItem = ({ label, checked, onChange, icon }: { label: string, checked: boolean, onChange: (val: boolean) => void, icon?: string }) => (
    <div className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark">
        <div className="flex items-center">
            {icon && <span className="material-symbols-outlined text-text-secondary-light dark:text-text-secondary-dark mr-4">{icon}</span>}
            <span className="text-base font-medium text-gray-900 dark:text-gray-100">{label}</span>
        </div>
        <button 
            onClick={() => onChange(!checked)}
            className={`w-12 h-7 rounded-full relative transition-colors duration-200 ease-in-out ${checked ? 'bg-[#8B5E3C]' : 'bg-gray-200 dark:bg-gray-700'}`}
        >
            <div className={`absolute top-1 w-5 h-5 bg-white rounded-full shadow-sm transition-transform duration-200 ease-in-out ${checked ? 'translate-x-6' : 'translate-x-1'}`}></div>
        </button>
    </div>
)

const SliderItem = ({ label, value, min, max, step, onChange, formatValue }: { label: string, value: number, min: number, max: number, step: number, onChange: (val: number) => void, formatValue?: (val: number) => string }) => (
    <div className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark">
        <div className="flex items-center space-x-3 w-1/3">
             <span className="text-base font-medium text-gray-900 dark:text-gray-100">{label}</span>
        </div>
        <div className="flex-1 flex items-center space-x-4 justify-end">
            <span className="text-sm text-text-secondary-light dark:text-text-secondary-dark w-12 text-right">
                {formatValue ? formatValue(value) : value}
            </span>
             <span className="material-symbols-outlined text-text-secondary-light dark:text-text-secondary-dark text-xl">chevron_right</span>
        </div>
    </div>
)

const CounterItem = ({ label, value, onChange, min = 0, max = 100 }: { label: string, value: number, onChange: (val: number) => void, min?: number, max?: number }) => (
    <div className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark">
        <div className="flex items-center space-x-3">
             <span className="material-symbols-outlined text-text-secondary-light dark:text-text-secondary-dark">format_list_numbered</span>
             <span className="text-base font-medium text-gray-900 dark:text-gray-100">{label}</span>
        </div>
        <div className="flex items-center space-x-4">
             <button 
                onClick={() => onChange(Math.max(min, value - 1))}
                className="w-8 h-8 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
             >
                 <span className="material-symbols-outlined text-sm">remove</span>
             </button>
             <span className="text-base text-gray-900 dark:text-gray-100 w-6 text-center">{value}</span>
             <button 
                onClick={() => onChange(Math.min(max, value + 1))}
                className="w-8 h-8 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center text-gray-600 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors"
             >
                 <span className="material-symbols-outlined text-sm">add</span>
             </button>
        </div>
    </div>
);

const ValueItem = ({ label, value, icon, onClick, isLink }: { label: string, value?: string, icon?: string, onClick?: () => void, isLink?: boolean }) => (
    <button onClick={onClick} className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark hover:bg-black/5 dark:hover:bg-white/5 transition-colors">
        <div className="flex items-center space-x-3">
             {icon && <span className="material-symbols-outlined text-text-secondary-light dark:text-text-secondary-dark">{icon}</span>}
             <span className="text-base font-medium text-gray-900 dark:text-gray-100">{label}</span>
        </div>
        <div className="flex items-center space-x-2">
            {value && <span className="text-sm text-text-secondary-light dark:text-text-secondary-dark">{value}</span>}
            {(isLink || value) && <span className="material-symbols-outlined text-text-secondary-light dark:text-text-secondary-dark text-xl">chevron_right</span>}
        </div>
    </button>
)

const InputItem = ({ label, value, onChange, placeholder }: { label: string, value: string, onChange: (val: string) => void, placeholder?: string }) => (
    <div className="w-full p-4 bg-card-light dark:bg-card-dark">
        <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">{label}</div>
        <input 
            type="text"
            className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
            placeholder={placeholder}
            value={value}
            onChange={(e) => onChange(e.target.value)}
        />
    </div>
)

const SectionGroup: React.FC<{ title?: string; children: React.ReactNode; className?: string }> = ({ title, children, className }) => (
  <div className={`mb-6 ${className || ''}`}>
    {title && <h2 className="text-sm font-medium text-text-secondary-light dark:text-text-secondary-dark mb-2 px-4 uppercase tracking-wide">{title}</h2>}
    <div className="bg-card-light dark:bg-card-dark rounded-2xl shadow-sm border border-border-light dark:border-border-dark overflow-hidden flex flex-col divide-y divide-border-light dark:divide-border-dark">
      {children}
    </div>
  </div>
);

// --- Model Card Component ---

interface ModelCardProps {
    icon: string;
    title: string;
    description: string;
    onReset: () => void;
    onSettings: () => void;
    children: React.ReactNode;
}

const ModelCard: React.FC<ModelCardProps> = ({ 
    icon, 
    title, 
    description, 
    onReset, 
    onSettings, 
    children 
}) => (
    <div className="mb-6 bg-card-light dark:bg-card-dark rounded-3xl p-5 shadow-sm border border-border-light dark:border-border-dark">
        <div className="flex items-center justify-between mb-3">
            <div className="flex items-center space-x-3">
                <span className="material-symbols-outlined text-gray-900 dark:text-gray-100">{icon}</span>
                <span className="font-bold text-gray-900 dark:text-gray-100 text-lg">{title}</span>
            </div>
            <div className="flex items-center space-x-1">
                <button onClick={onReset} className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-400 transition-colors">
                    <span className="material-symbols-outlined text-xl">restart_alt</span>
                </button>
                <button onClick={onSettings} className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-600 dark:text-gray-400 transition-colors">
                    <span className="material-symbols-outlined text-xl">settings</span>
                </button>
            </div>
        </div>
        <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-4 leading-relaxed">
            {description}
        </p>
        <div>{children}</div>
    </div>
);

// --- Model Prompt Editor Component ---
const ModelPromptEditor = ({
    title,
    prompt,
    onUpdate,
    onBack
}: {
    title: string,
    prompt: string,
    onUpdate: (val: string) => void,
    onBack: () => void
}) => {
    return (
         <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
            <Header title={`${title} - 设置`} onBack={onBack} />
            <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar">
                <div className="flex flex-col h-full pb-6">
                    <h2 className="text-sm font-bold text-gray-900 dark:text-gray-100 mb-2 px-1">自定义提示词</h2>
                    <div className="bg-card-light dark:bg-card-dark rounded-2xl shadow-sm border border-border-light dark:border-border-dark flex-1 p-4 flex flex-col h-96">
                        <textarea 
                            className="w-full h-full bg-transparent border-none resize-none focus:ring-0 text-base leading-relaxed text-gray-800 dark:text-gray-200 p-0"
                            placeholder="输入自定义提示词..."
                            value={prompt}
                            onChange={(e) => onUpdate(e.target.value)}
                        />
                    </div>
                    <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-4 px-2">
                        在此处设置的提示词将覆盖该模型功能的默认系统行为。清空内容以恢复默认。
                    </p>
                </div>
            </main>
        </div>
    );
};


// --- Assistant Editor Sub-Component (Moved Outside) ---
const AssistantEditor = ({ 
    assistantId, 
    assistants,
    onUpdate,
    onBack 
}: { 
    assistantId: string, 
    assistants: Assistant[],
    onUpdate: (updated: Assistant) => void,
    onBack: () => void 
}) => {
    const assistant = assistants.find(a => a.id === assistantId);
    const [activeTab, setActiveTab] = useState<'basic' | 'prompt' | 'memory' | 'quick'>('basic');
    
    if (!assistant) return null;

    const updateField = (field: keyof Assistant, value: any) => {
        onUpdate({ ...assistant, [field]: value });
    };

    const tabs = [
        { id: 'basic', label: '基础设置' },
        { id: 'prompt', label: '提示词' },
        { id: 'memory', label: '记忆' },
        { id: 'quick', label: '快捷短语' },
    ];

    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
            <Header title={assistant.name} onBack={onBack} />
            
            {/* Tab Bar */}
            <div className="flex items-center justify-around px-2 py-2 border-b border-gray-100 dark:border-gray-800 bg-background-light dark:bg-background-dark shrink-0">
                {tabs.map(tab => (
                    <button
                      key={tab.id}
                      onClick={() => setActiveTab(tab.id as any)}
                      className={`px-4 py-2 text-sm font-medium rounded-full transition-colors ${
                          activeTab === tab.id 
                              ? 'bg-[#F2E8E8] dark:bg-[#3E3E3E] text-gray-900 dark:text-gray-100' 
                              : 'text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-900'
                      }`}
                    >
                        {tab.label}
                    </button>
                ))}
            </div>

            {/* Tab Content */}
            <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar bg-[#F9F9F9] dark:bg-[#000000]">
                {activeTab === 'basic' && (
                    <div className="space-y-6">
                        {/* Avatar & Name */}
                        <div className="flex flex-col items-center justify-center py-4 bg-card-light dark:bg-card-dark rounded-2xl shadow-sm border border-border-light dark:border-border-dark">
                             <div className="w-20 h-20 rounded-full bg-[#E4D5D5] flex items-center justify-center mb-4">
                                 <span className="text-4xl text-[#5E4035]">{assistant.avatar}</span>
                             </div>
                             <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">助手名称</div>
                             <input 
                                value={assistant.name}
                                onChange={(e) => updateField('name', e.target.value)}
                                className="text-center bg-gray-100 dark:bg-gray-800 border-none rounded-xl py-2 px-4 text-gray-900 dark:text-gray-100 focus:ring-2 focus:ring-[#E4D5D5] outline-none w-3/4"
                             />
                        </div>

                        <SectionGroup>
                            <SliderItem 
                                label="Temperature" 
                                value={assistant.temperature} 
                                min={0} max={1} step={0.01} 
                                onChange={(v) => updateField('temperature', v)}
                                formatValue={(v) => v.toFixed(2)}
                            />
                            <SliderItem 
                                label="Top P" 
                                value={assistant.topP} 
                                min={0} max={1} step={0.01} 
                                onChange={(v) => updateField('topP', v)}
                                formatValue={(v) => v.toFixed(2)}
                            />
                            <ValueItem label="上下文消息数量" value={assistant.contextMessageCount.toString()} onClick={() => {}} />
                            <ValueItem label="思考预算" value="-" onClick={() => {}} />
                            <ValueItem label="最大 Token 数" value={assistant.maxOutputTokens.toString()} onClick={() => {}} />
                        </SectionGroup>

                        <SectionGroup>
                            <ToggleItem 
                              label="使用助手头像" 
                              checked={assistant.useAvatar} 
                              onChange={(v) => updateField('useAvatar', v)} 
                              icon="person"
                            />
                            <ToggleItem 
                              label="流式输出" 
                              checked={assistant.streamOutput} 
                              onChange={(v) => updateField('streamOutput', v)} 
                              icon="bolt"
                            />
                        </SectionGroup>

                        <div className="pb-6">
                            <h2 className="text-sm font-medium text-text-secondary-light dark:text-text-secondary-dark mb-2 px-4 flex items-center">
                                <span className="material-symbols-outlined mr-2 text-lg">chat_bubble_outline</span>
                                聊天模型
                            </h2>
                            <div className="px-4 text-xs text-text-secondary-light dark:text-text-secondary-dark mb-2">
                                为该助手设置默认聊天模型 (未设置时使用全局默认)
                            </div>
                            <div className="bg-card-light dark:bg-card-dark rounded-2xl p-2 shadow-sm border border-border-light dark:border-border-dark">
                                <button className="flex items-center space-x-2 px-3 py-2 bg-gray-100 dark:bg-gray-800 rounded-lg text-sm text-gray-700 dark:text-gray-300">
                                    <span className="w-5 h-5 flex items-center justify-center bg-[#E4D5D5] text-[#5E4035] rounded-full text-xs font-bold">使</span>
                                    <span>使用全局默认</span>
                                </button>
                            </div>
                        </div>
                        
                        <div className="pb-8">
                             <h2 className="text-sm font-medium text-text-secondary-light dark:text-text-secondary-dark mb-2 px-4 flex items-center">
                                <span className="material-symbols-outlined mr-2 text-lg">image</span>
                                聊天背景
                            </h2>
                            <div className="px-4 text-xs text-text-secondary-light dark:text-text-secondary-dark mb-2">
                                设置助手聊天页面的背景图片
                            </div>
                            <button className="w-full mx-auto block max-w-[92%] py-3 bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300 rounded-xl text-sm font-medium hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors flex items-center justify-center">
                                <span className="material-symbols-outlined mr-2">image</span>
                                选择背景图片
                            </button>
                        </div>
                    </div>
                )}

                {activeTab === 'prompt' && (
                    <div className="space-y-6 h-full flex flex-col">
                        <div className="flex-1 flex flex-col">
                            <h2 className="text-sm font-bold text-gray-900 dark:text-gray-100 mb-2 px-1">系统提示词</h2>
                            <div className="bg-card-light dark:bg-card-dark rounded-2xl shadow-sm border border-border-light dark:border-border-dark flex-1 p-4 flex flex-col">
                                <textarea 
                                    className="w-full h-64 bg-transparent border-none resize-none focus:ring-0 text-base leading-relaxed text-gray-800 dark:text-gray-200 p-0"
                                    placeholder="输入系统提示词..."
                                    value={assistant.systemPrompt}
                                    onChange={(e) => updateField('systemPrompt', e.target.value)}
                                />
                                <div className="mt-4 pt-4 border-t border-border-light dark:border-border-dark">
                                    <p className="text-xs font-bold text-gray-900 dark:text-gray-100 mb-2">可用变量:</p>
                                    <div className="flex flex-wrap gap-2 text-xs text-[#8B5E3C]">
                                        <span>日期: {'{cur_date}'}</span>
                                        <span>时间: {'{cur_time}'}</span>
                                        <span>日期和时间: {'{cur_datetime}'}</span>
                                        <span>模型ID: {'{model_id}'}</span>
                                        <span>模型名称: {'{model_name}'}</span>
                                        <span>语言环境: {'{locale}'}</span>
                                        <span>时区: {'{timezone}'}</span>
                                        <span>系统版本: {'{system_version}'}</span>
                                        <span>设备信息: {'{device_info}'}</span>
                                        <span>电池电量: {'{battery_level}'}</span>
                                        <span>用户昵称: {'{nickname}'}</span>
                                        <span>助手名称: {'{assistant_name}'}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                         <div className="pb-8 mt-4">
                            <h2 className="text-sm font-bold text-gray-900 dark:text-gray-100 mb-2 px-1">聊天内容模板</h2>
                            <div className="bg-card-light dark:bg-card-dark rounded-2xl shadow-sm border border-border-light dark:border-border-dark p-4">
                                 <div className="text-base text-gray-800 dark:text-gray-200 font-mono mb-4">{`{{ message }}`}</div>
                                 <div className="pt-4 border-t border-border-light dark:border-border-dark">
                                    <p className="text-xs font-bold text-gray-900 dark:text-gray-100 mb-2">可用变量:</p>
                                    <div className="flex flex-wrap gap-2 text-xs text-[#8B5E3C]">
                                        <span>角色: {'{role}'}</span>
                                        <span>内容: {'{message}'}</span>
                                        <span>时间: {'{time}'}</span>
                                        <span>日期: {'{date}'}</span>
                                    </div>
                                </div>
                            </div>
                            <div className="mt-2 text-xs text-text-secondary-light dark:text-text-secondary-dark px-1">预览</div>
                         </div>
                    </div>
                )}

                {activeTab === 'memory' && (
                    <div className="space-y-6">
                         <SectionGroup>
                            <ToggleItem 
                              label="记忆" 
                              checked={assistant.enableMemory} 
                              onChange={(v) => updateField('enableMemory', v)} 
                              icon="favorite_border"
                            />
                         </SectionGroup>
                         
                         <SectionGroup>
                            <ToggleItem 
                              label="参考历史聊天记录" 
                              checked={assistant.enableHistoryReference} 
                              onChange={(v) => updateField('enableHistoryReference', v)} 
                              icon="history"
                            />
                         </SectionGroup>

                         <div>
                             <div className="flex items-center justify-between px-4 mb-2">
                                 <h2 className="text-sm font-bold text-gray-900 dark:text-gray-100">管理记忆</h2>
                                 <button className="text-sm text-[#8B5E3C] font-medium flex items-center">
                                     <span className="material-symbols-outlined text-sm mr-1">add</span>
                                     添加记忆
                                 </button>
                             </div>
                             <div className="px-4 text-sm text-text-secondary-light dark:text-text-secondary-dark">
                                 {assistant.memories.length === 0 ? "暂无记忆" : assistant.memories.map((m, i) => (
                                     <div key={i} className="py-2 border-b border-border-light dark:border-border-dark last:border-0">{m}</div>
                                 ))}
                             </div>
                         </div>
                    </div>
                )}

                {activeTab === 'quick' && (
                     <div className="flex flex-col items-center justify-center h-3/4 text-center">
                          <span className="material-symbols-outlined text-6xl text-[#E4D5D5] mb-6 animate-pulse" style={{ fontSize: '80px', color: '#D4B5B5' }}>bolt</span>
                          <p className="text-text-secondary-light dark:text-text-secondary-dark mb-8 px-8">
                              管理该助手的快捷短语。点击下方按钮添加短语。
                          </p>
                          <button className="px-6 py-3 bg-[#8B5E3C] text-white rounded-xl font-medium shadow-md active:scale-95 transition-transform flex items-center">
                              <span className="material-symbols-outlined mr-2">add</span>
                              添加快捷短语
                          </button>
                     </div>
                )}
                <div className="h-12" /> {/* Bottom Spacer */}
            </main>
        </div>
    );
};

// --- Provider Detail Editor ---
const ProviderDetailEditor = ({
    provider,
    onUpdate,
    onBack
}: {
    provider: Provider,
    onUpdate: (p: Provider) => void,
    onBack: () => void
}) => {
    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
            <header className="flex items-center justify-between px-4 py-4 bg-background-light dark:bg-background-dark border-b border-gray-100 dark:border-gray-800 shrink-0 sticky top-0 z-10">
                <div className="flex items-center">
                    <button onClick={onBack} className="p-2 -ml-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
                        <span className="material-symbols-outlined text-2xl text-gray-800 dark:text-gray-200">arrow_back</span>
                    </button>
                    <div className="ml-2 flex items-center space-x-2">
                        {provider.icon.length === 1 ? (
                             <div className="w-6 h-6 rounded-full bg-[#E4D5D5] flex items-center justify-center text-xs font-bold text-[#5E4035]">
                                {provider.icon}
                             </div>
                        ) : (
                             <span className="material-symbols-outlined text-xl">{provider.icon}</span>
                        )}
                        <h1 className="text-xl font-medium text-gray-900 dark:text-gray-100">{provider.name}</h1>
                    </div>
                </div>
                <div className="flex items-center space-x-1">
                    <button className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-800 dark:text-gray-200 transition-colors">
                         <span className="material-symbols-outlined text-2xl">favorite_border</span>
                    </button>
                    <button className="p-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 text-gray-800 dark:text-gray-200 transition-colors">
                         <span className="material-symbols-outlined text-2xl">share</span>
                    </button>
                </div>
            </header>
            
            <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
                 <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">管理</div>
                 
                 <SectionGroup>
                     <ValueItem label="供应商类型" value={provider.type} onClick={() => {}} />
                     <ToggleItem 
                        label="是否启用" 
                        checked={provider.isEnabled} 
                        onChange={(v) => onUpdate({...provider, isEnabled: v})}
                     />
                 </SectionGroup>

                 <SectionGroup>
                      <ToggleItem 
                        label="多Key模式" 
                        checked={provider.isMultiKey || false} 
                        onChange={(v) => onUpdate({...provider, isMultiKey: v})}
                        icon="key"
                      />
                      <ToggleItem 
                        label="Response API" 
                        checked={provider.responseApi || false} 
                        onChange={(v) => onUpdate({...provider, responseApi: v})}
                        icon="api"
                      />
                      <ValueItem label="网络代理" value="" icon="public" isLink onClick={() => {}} />
                 </SectionGroup>

                 <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">配置</div>
                 <SectionGroup>
                      <InputItem 
                        label="名称" 
                        value={provider.name} 
                        onChange={(v) => onUpdate({...provider, name: v})}
                      />
                      <div className="w-full p-4 bg-card-light dark:bg-card-dark border-t border-border-light dark:border-border-dark">
                        <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">API Key</div>
                        <input 
                            type="password"
                            className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="sk-..."
                            value={provider.apiKey || ''}
                            onChange={(e) => onUpdate({...provider, apiKey: e.target.value})}
                        />
                         <div className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-2">留空则使用上层默认</div>
                      </div>
                      <div className="w-full p-4 bg-card-light dark:bg-card-dark border-t border-border-light dark:border-border-dark">
                         <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">API Base URL</div>
                         <input 
                            type="text"
                            className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="https://api.openai.com/v1"
                            value={provider.baseUrl || ''}
                            onChange={(e) => onUpdate({...provider, baseUrl: e.target.value})}
                        />
                      </div>
                      <div className="w-full p-4 bg-card-light dark:bg-card-dark border-t border-border-light dark:border-border-dark">
                         <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">API 路径</div>
                         <input 
                            type="text"
                            className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="/chat/completions"
                            value={provider.apiPath || '/chat/completions'}
                            onChange={(e) => onUpdate({...provider, apiPath: e.target.value})}
                        />
                      </div>
                 </SectionGroup>

                 <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">模型管理</div>
                 
                 <div className="flex items-center space-x-2 mb-4 px-1">
                     <button className="flex-1 py-3 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-xl text-sm font-medium text-gray-700 dark:text-gray-300 flex items-center justify-center">
                         <span className="material-symbols-outlined mr-2 text-lg">sync</span>
                         获取
                     </button>
                      <button className="flex-1 py-3 bg-[#F2E8E8] dark:bg-[#3E3E3E] rounded-xl text-sm font-medium text-[#8B5E3C] dark:text-[#E4D5D5] flex items-center justify-center">
                         <span className="material-symbols-outlined mr-2 text-lg">add</span>
                         添加新模型
                     </button>
                 </div>
                 
                 <div className="space-y-3">
                     {provider.models.map((model, idx) => (
                         <div key={idx} className="flex items-center justify-between p-3 bg-card-light dark:bg-card-dark rounded-xl border border-border-light dark:border-border-dark">
                             <div className="flex items-center space-x-3">
                                 <div className="w-8 h-8 rounded-lg bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
                                     <span className="material-symbols-outlined text-gray-500">deployed_code</span>
                                 </div>
                                 <div className="flex flex-col">
                                     <span className="text-sm font-medium text-gray-900 dark:text-gray-100">{model}</span>
                                     <div className="flex space-x-2 mt-1">
                                         <span className="px-1.5 py-0.5 bg-gray-100 dark:bg-gray-800 rounded text-[10px] text-gray-500">聊天</span>
                                         <span className="px-1.5 py-0.5 bg-gray-100 dark:bg-gray-800 rounded text-[10px] text-gray-500">T &gt; T</span>
                                     </div>
                                 </div>
                             </div>
                             <div className="flex items-center space-x-1 text-gray-400">
                                 <button className="p-1"><span className="material-symbols-outlined text-lg">construction</span></button>
                                 <button className="p-1"><span className="material-symbols-outlined text-lg">grid_view</span></button>
                             </div>
                         </div>
                     ))}
                 </div>
            </main>
        </div>
    )
}

// --- Search Provider Editor ---
const SearchProviderDetailEditor = ({
    provider,
    onUpdate,
    onBack
}: {
    provider: SearchProvider,
    onUpdate: (p: SearchProvider) => void,
    onBack: () => void
}) => {
    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
            <Header title={provider.name} onBack={onBack} />
             <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
                 <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">搜索提供商</div>
                 <div className="bg-card-light dark:bg-card-dark rounded-2xl p-4 shadow-sm border border-border-light dark:border-border-dark mb-6 flex items-center space-x-4">
                     <div className="w-10 h-10 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
                         {provider.icon.length > 2 ? <span className="material-symbols-outlined">{provider.icon}</span> : <span className="font-bold">{provider.icon}</span>}
                     </div>
                     <span className="text-lg font-medium text-gray-900 dark:text-gray-100">{provider.name}</span>
                 </div>
                 
                 {provider.type === 'api' && (
                     <>
                        <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">配置</div>
                        <SectionGroup>
                             <div className="w-full p-4 bg-card-light dark:bg-card-dark">
                                <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">API Key</div>
                                <input 
                                    type="password"
                                    className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                                    placeholder="输入 API Key"
                                    value={provider.apiKey || ''}
                                    onChange={(e) => onUpdate({...provider, apiKey: e.target.value})}
                                />
                             </div>
                        </SectionGroup>
                     </>
                 )}

                 <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">通用选项</div>
                 <SectionGroup>
                     <CounterItem 
                        label="最大结果数" 
                        value={provider.maxResults} 
                        onChange={(v) => onUpdate({...provider, maxResults: v})} 
                     />
                     <div className="h-px bg-border-light dark:bg-border-dark"></div>
                     <CounterItem 
                        label="超时时间 (秒)" 
                        value={provider.timeout} 
                        onChange={(v) => onUpdate({...provider, timeout: v})}
                        max={60} 
                     />
                 </SectionGroup>
                 
                 <div className="mt-8">
                     <button 
                        onClick={onBack}
                        className="w-full py-4 bg-[#8B5E3C] text-white rounded-2xl font-medium shadow-md active:scale-95 transition-transform"
                     >
                         添加
                     </button>
                 </div>
             </main>
        </div>
    )
}

// --- Quick Phrase Editor ---
const QuickPhraseEditor = ({
  phrase,
  isNew,
  onSave,
  onBack,
  onDelete
}: {
  phrase: QuickPhrase;
  isNew: boolean;
  onSave: (p: QuickPhrase) => void;
  onBack: () => void;
  onDelete?: (id: string) => void;
}) => {
  const [data, setData] = useState(phrase);

  const handlePhraseChange = (val: string) => {
    let newShortcut = data.shortcut;
    // Simple auto-shortcut generation logic if shortcut is empty or matches previous auto-gen
    if (!data.shortcut || data.shortcut === data.phrase.slice(0, 3)) {
        newShortcut = val.slice(0, 3);
    }
    setData({ ...data, phrase: val, shortcut: newShortcut });
  };

  return (
    <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
      <Header title={isNew ? "添加快捷短语" : "编辑快捷短语"} onBack={onBack} />
      <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar">
        <SectionGroup title="内容">
          <InputItem 
            label="短语内容" 
            value={data.phrase} 
            onChange={handlePhraseChange} 
            placeholder="输入常用的短语..."
          />
        </SectionGroup>
        
        <SectionGroup title="快捷指令">
          <InputItem 
            label="快捷输入码" 
            value={data.shortcut} 
            onChange={(val) => setData({...data, shortcut: val})} 
            placeholder="输入快捷码 (例如: hns)"
          />
          <div className="p-4 text-xs text-text-secondary-light dark:text-text-secondary-dark">
             在输入框输入该快捷码，可快速发送对应的短语内容。默认取前3个字。
          </div>
        </SectionGroup>

        <div className="mt-8 space-y-3">
             <button 
                onClick={() => onSave(data)}
                className="w-full py-4 bg-[#8B5E3C] text-white rounded-2xl font-medium shadow-md active:scale-95 transition-transform"
             >
                 保存
             </button>
             {!isNew && onDelete && (
                 <button 
                    onClick={() => { onDelete(data.id); }}
                    className="w-full py-4 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-2xl font-medium active:scale-95 transition-transform"
                 >
                     删除
                 </button>
             )}
         </div>
      </main>
    </div>
  );
};

// --- MCP Editor Components ---

const MCPToolItem: React.FC<{ tool: MCPTool, onToggle: () => void }> = ({ tool, onToggle }) => (
  <div className="bg-card-light dark:bg-card-dark rounded-2xl p-4 shadow-sm border border-border-light dark:border-border-dark mb-4">
    <div className="flex items-center justify-between mb-2">
       <span className="text-base font-bold text-gray-900 dark:text-gray-100">{tool.name}</span>
       <div className={`w-12 h-7 rounded-full relative transition-colors duration-200 ease-in-out cursor-pointer ${tool.isEnabled ? 'bg-[#8B5E3C]' : 'bg-gray-200 dark:bg-gray-700'}`} onClick={onToggle}>
            <div className={`absolute top-1 w-5 h-5 bg-white rounded-full shadow-sm transition-transform duration-200 ease-in-out ${tool.isEnabled ? 'translate-x-6' : 'translate-x-1'}`}></div>
       </div>
    </div>
    <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-3">{tool.description}</p>
    <div className="flex flex-wrap gap-2">
        {tool.args.map((arg, i) => (
            <span key={i} className="px-2 py-1 rounded-lg bg-[#F2E8E8] dark:bg-[#3E3E3E] text-[#8B5E3C] dark:text-[#E4D5D5] text-xs border border-[#E4D5D5] dark:border-[#5E4035]">
                {arg}
            </span>
        ))}
    </div>
  </div>
);

const MCPEditor = ({
    server,
    isNew,
    onUpdate,
    onBack,
    onDelete
}: {
    server: MCPServer,
    isNew: boolean,
    onUpdate: (s: MCPServer) => void,
    onBack: () => void,
    onDelete?: (id: string) => void
}) => {
    const [activeTab, setActiveTab] = useState<'basic' | 'tools'>('basic');
    const tabs = [
        { id: 'basic', label: '基础设置' },
        { id: 'tools', label: '工具' },
    ];

    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
             <Header title={isNew ? "添加 MCP" : "编辑 MCP"} onBack={onBack} secondaryActionIcon="refresh" />
             
             {/* Tab Bar */}
            <div className="flex items-center justify-center space-x-4 px-2 py-2 border-b border-gray-100 dark:border-gray-800 bg-background-light dark:bg-background-dark shrink-0">
                {tabs.map(tab => (
                    <button
                      key={tab.id}
                      onClick={() => setActiveTab(tab.id as any)}
                      className={`px-12 py-2 text-sm font-medium rounded-xl transition-colors ${
                          activeTab === tab.id 
                              ? 'bg-[#F2E8E8] dark:bg-[#3E3E3E] text-gray-900 dark:text-gray-100' 
                              : 'text-gray-500 dark:text-gray-400 hover:bg-gray-50 dark:hover:bg-gray-900'
                      }`}
                    >
                        {tab.label}
                    </button>
                ))}
            </div>

            <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8 bg-[#F9F9F9] dark:bg-[#000000]">
                {activeTab === 'basic' && (
                    <div className="space-y-6">
                        <SectionGroup>
                             <ToggleItem 
                                label="是否启用" 
                                checked={server.isEnabled} 
                                onChange={(v) => onUpdate({...server, isEnabled: v})}
                             />
                        </SectionGroup>

                        <SectionGroup>
                            <InputItem 
                                label="名称" 
                                value={server.name} 
                                onChange={(v) => onUpdate({...server, name: v})} 
                            />
                            <div className="w-full p-4 bg-card-light dark:bg-card-dark border-t border-border-light dark:border-border-dark">
                                <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">传输类型</div>
                                <div className="flex space-x-2">
                                    <button 
                                        className={`flex-1 py-2 rounded-xl text-sm font-medium transition-colors ${server.type === 'Streamable HTTP' ? 'bg-[#F2E8E8] text-[#8B5E3C] border border-[#E4D5D5]' : 'bg-gray-100 text-gray-600'}`}
                                        onClick={() => onUpdate({...server, type: 'Streamable HTTP'})}
                                    >
                                        Streamable HTTP
                                    </button>
                                    <button 
                                        className={`flex-1 py-2 rounded-xl text-sm font-medium transition-colors ${server.type === 'SSE' ? 'bg-[#F2E8E8] text-[#8B5E3C] border border-[#E4D5D5]' : 'bg-gray-100 text-gray-600'}`}
                                        onClick={() => onUpdate({...server, type: 'SSE'})}
                                    >
                                        SSE
                                    </button>
                                </div>
                            </div>
                            <div className="w-full p-4 bg-card-light dark:bg-card-dark border-t border-border-light dark:border-border-dark">
                                <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">服务器地址</div>
                                <input 
                                    type="text"
                                    className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                                    placeholder="http://localhost:3000"
                                    value={server.url}
                                    onChange={(e) => onUpdate({...server, url: e.target.value})}
                                />
                            </div>
                        </SectionGroup>

                        <div>
                             <div className="flex items-center justify-between px-4 mb-2">
                                 <h2 className="text-sm font-bold text-gray-900 dark:text-gray-100">自定义请求头</h2>
                                 <button className="px-3 py-1.5 bg-[#F2E8E8] dark:bg-[#3E3E3E] rounded-lg text-xs font-medium text-[#8B5E3C] dark:text-[#E4D5D5] flex items-center">
                                     <span className="material-symbols-outlined text-sm mr-1">add</span>
                                     添加请求头
                                 </button>
                             </div>
                        </div>

                         <div className="mt-8 space-y-3">
                             <button 
                                onClick={onBack}
                                className="w-full py-4 bg-[#8B5E3C] text-white rounded-2xl font-medium shadow-md active:scale-95 transition-transform"
                             >
                                 保存
                             </button>
                             {!isNew && onDelete && (
                                 <button 
                                    onClick={() => { onDelete(server.id); onBack(); }}
                                    className="w-full py-4 bg-red-50 dark:bg-red-900/20 text-red-600 dark:text-red-400 rounded-2xl font-medium active:scale-95 transition-transform"
                                 >
                                     删除
                                 </button>
                             )}
                         </div>
                    </div>
                )}

                {activeTab === 'tools' && (
                    <div className="space-y-4">
                         {server.tools.map((tool, idx) => (
                             <MCPToolItem 
                                key={idx} 
                                tool={tool} 
                                onToggle={() => {
                                    const newTools = [...server.tools];
                                    newTools[idx] = { ...tool, isEnabled: !tool.isEnabled };
                                    onUpdate({ ...server, tools: newTools });
                                }}
                             />
                         ))}
                         {server.tools.length === 0 && (
                             <div className="flex flex-col items-center justify-center h-40 text-text-secondary-light dark:text-text-secondary-dark">
                                 <p>暂无可用工具</p>
                             </div>
                         )}
                    </div>
                )}
            </main>
        </div>
    );
}


// --- About Page ---
const AboutPage = ({ onBack }: { onBack: () => void }) => {
    return (
      <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
        <Header title="关于" onBack={onBack} />
        <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
            <div className="flex flex-col items-start mb-8 px-4">
                 <div className="flex items-center space-x-4 mb-2">
                     <div className="w-16 h-16 rounded-full bg-gradient-to-tr from-blue-500 to-purple-500 flex items-center justify-center text-white">
                        <span className="material-symbols-outlined text-4xl">smart_toy</span>
                     </div>
                     <div>
                        <h1 className="text-2xl font-bold text-gray-900 dark:text-gray-100">Cometix</h1>
                        <p className="text-text-secondary-light dark:text-text-secondary-dark">开源AI 助手</p>
                     </div>
                 </div>
            </div>
            
            <SectionGroup>
                <ValueItem label="版本" value="1.1.2 / 2017" isLink onClick={() => {}} />
                <div className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark">
                     <span className="text-base font-medium text-gray-900 dark:text-gray-100">系统</span>
                     <span className="text-sm text-text-secondary-light dark:text-text-secondary-dark">Android</span>
                </div>
            </SectionGroup>
  
            <SectionGroup>
                <ValueItem label="官网" icon="language" isLink onClick={() => {}} />
                <ValueItem label="GitHub" icon="code" isLink onClick={() => {}} />
                <ValueItem label="许可证" icon="description" isLink onClick={() => {}} />
            </SectionGroup>
  
            <SectionGroup>
                <ValueItem label="加入QQ群" icon="group" isLink onClick={() => {}} />
                <ValueItem label="在 Discord 中加入我们" icon="forum" isLink onClick={() => {}} />
            </SectionGroup>
        </main>
      </div>
    );
  };
  
  // --- Sponsor Page ---
  const SponsorPage = ({ onBack }: { onBack: () => void }) => {
      const sponsors = [
          { name: 'wwxiaoqi', avatar: 'https://ui-avatars.com/api/?name=ww&background=random' },
          { name: 'orange1...', avatar: 'https://ui-avatars.com/api/?name=or&background=random' },
          { name: 'meeer', avatar: 'https://ui-avatars.com/api/?name=me&background=random' },
          { name: 'Jorben', avatar: 'https://ui-avatars.com/api/?name=Jo&background=random' },
          { name: 'stou', avatar: 'https://ui-avatars.com/api/?name=st&background=random' },
          { name: 'Gordon', avatar: 'https://ui-avatars.com/api/?name=Go&background=random' },
          { name: '阳月🌙', avatar: 'https://ui-avatars.com/api/?name=YY&background=random' },
          { name: 'JaqenZe', avatar: 'https://ui-avatars.com/api/?name=Ja&background=random' },
          { name: 'thinking', avatar: 'https://ui-avatars.com/api/?name=th&background=random' },
          { name: '昼月无寂', avatar: 'https://ui-avatars.com/api/?name=ZY&background=random' },
      ];
  
      return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
          <Header title="赞助" onBack={onBack} />
          <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
              <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">赞助方式</div>
              <SectionGroup>
                  <ValueItem label="爱发电" icon="favorite" isLink onClick={() => {}} />
                  <ValueItem label="微信赞助" icon="link" isLink onClick={() => {}} />
              </SectionGroup>
              
              <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">赞助用户</div>
              <div className="grid grid-cols-4 gap-4 px-2">
                  {sponsors.map((user, idx) => (
                      <div key={idx} className="flex flex-col items-center">
                          <img src={user.avatar} alt={user.name} className="w-14 h-14 rounded-full mb-2 bg-gray-200 object-cover" />
                          <span className="text-xs text-center text-text-secondary-light dark:text-text-secondary-dark truncate w-full">{user.name}</span>
                      </div>
                  ))}
              </div>
          </main>
        </div>
      );
  };

// --- Dummy Data ---
const initialAssistants: Assistant[] = [
    {
        id: '1',
        name: 'Default Assistant',
        avatar: 'D',
        description: '暂无提示词',
        isDefault: true,
        temperature: 0.5,
        topP: 0.95,
        contextMessageCount: 10,
        maxOutputTokens: '无限制',
        useAvatar: true,
        streamOutput: true,
        chatModel: '使用全局默认',
        systemPrompt: '',
        enableMemory: false,
        enableHistoryReference: false,
        memories: [],
        quickPhrases: []
    },
    {
        id: '2',
        name: 'Sample Assistant',
        avatar: 'S',
        description: 'You are {model_name}, an AI assistant who...',
        isDefault: true,
        temperature: 0.60,
        topP: 1.00,
        contextMessageCount: 64,
        maxOutputTokens: '无限制',
        useAvatar: false,
        streamOutput: true,
        chatModel: '使用全局默认',
        systemPrompt: 'You are {model_name}, an AI assistant who gladly provides accurate and helpful assistance. The current time is {cur_datetime}, the device language is "{locale}", timezone is {timezone}, the user is using {device_info}, version {system_version}. If the user does not explicitly specify otherwise, please',
        enableMemory: false,
        enableHistoryReference: false,
        memories: [],
        quickPhrases: []
    },
    {
        id: '3',
        name: '1',
        avatar: '1',
        description: '暂无提示词',
        isDefault: false,
        temperature: 0.7,
        topP: 0.9,
        contextMessageCount: 20,
        maxOutputTokens: '2048',
        useAvatar: true,
        streamOutput: true,
        chatModel: 'Gemini 2.5 Flash',
        systemPrompt: '',
        enableMemory: true,
        enableHistoryReference: true,
        memories: ['用户喜欢喝咖啡', '用户是一名程序员'],
        quickPhrases: ['解释代码', '翻译']
    }
];

const initialProviders: Provider[] = [
    { id: '1', name: 'OpenAI', type: 'OpenAI', isEnabled: true, icon: 'O', models: ['gpt-4o', 'gpt-4o-mini', 'gpt-3.5-turbo'], apiKey: '', baseUrl: 'https://api.openai.com/v1' },
    { id: '2', name: 'SiliconFlow', type: 'SiliconFlow', isEnabled: true, icon: 'S', models: ['THUDM/GLM-4-9B-0414', 'Qwen/Qwen3-8B'], apiKey: '', baseUrl: 'https://api.siliconflow.cn/v1' },
    { id: '3', name: 'Gemini', type: 'Google', isEnabled: true, icon: 'G', models: ['gemini-2.5-flash', 'gemini-1.5-pro'], apiKey: '', baseUrl: '' },
    { id: '4', name: 'OpenRouter', type: 'OpenAI', isEnabled: true, icon: 'R', models: [], apiKey: '', baseUrl: '' },
    { id: '5', name: 'KelivoIN', type: 'OpenAI', isEnabled: true, icon: 'K', models: [], apiKey: '', baseUrl: '' },
    { id: '6', name: 'Tensdaq', type: 'OpenAI', isEnabled: true, icon: 'T', models: [], apiKey: '', baseUrl: '' },
    { id: '7', name: 'DeepSeek', type: 'DeepSeek', isEnabled: false, icon: 'D', models: ['deepseek-chat', 'deepseek-coder'], apiKey: '', baseUrl: '' },
    { id: '8', name: '阿里云千问', type: 'OpenAI', isEnabled: false, icon: 'A', models: [], apiKey: '', baseUrl: '' },
    { id: '9', name: '智谱', type: 'OpenAI', isEnabled: false, icon: 'Z', models: [], apiKey: '', baseUrl: '' },
    { id: '10', name: 'Claude', type: 'Anthropic', isEnabled: false, icon: 'C', models: [], apiKey: '', baseUrl: '' },
    { id: '11', name: 'Grok', type: 'OpenAI', isEnabled: false, icon: 'G', models: [], apiKey: '', baseUrl: '' },
    { id: '12', name: '火山引擎', type: 'OpenAI', isEnabled: false, icon: 'H', models: [], apiKey: '', baseUrl: '' },
];

const initialSearchProviders: SearchProvider[] = [
    { id: '1', name: 'Bing (Local)', icon: 'search', type: 'local', maxResults: 10, timeout: 5 },
    { id: '2', name: 'DuckDuckGo', icon: 'pest_control', type: 'local', maxResults: 10, timeout: 5 },
    { id: '3', name: 'Tavily', icon: 'T', type: 'api', maxResults: 5, timeout: 10 },
    { id: '4', name: 'Exa', icon: 'E', type: 'api', maxResults: 5, timeout: 10 },
    { id: '5', name: '智谱', icon: 'Z', type: 'api', maxResults: 5, timeout: 10 },
    { id: '6', name: 'SearXNG', icon: 'search', type: 'api', maxResults: 10, timeout: 5 },
    { id: '7', name: 'LinkUp', icon: 'link', type: 'api', maxResults: 5, timeout: 10 },
    { id: '8', name: 'Brave', icon: 'shield', type: 'api', maxResults: 10, timeout: 5 },
    { id: '9', name: '秘塔', icon: 'M', type: 'api', maxResults: 5, timeout: 10 },
    { id: '10', name: 'Jina', icon: 'J', type: 'api', maxResults: 5, timeout: 10 },
    { id: '11', name: 'Ollama', icon: 'smart_toy', type: 'api', maxResults: 1, timeout: 30 },
]

const initialMCPServers: MCPServer[] = [
    {
        id: '1',
        name: '@kelivo/fetch',
        type: 'Streamable HTTP',
        url: 'http://localhost:3000',
        isEnabled: true,
        status: 'connected',
        isBuiltIn: true,
        tools: [
            { name: 'fetch_html', description: 'Fetch a website and return the content as HTML', isEnabled: true, args: ['url', 'headers'] },
            { name: 'fetch_markdown', description: 'Fetch a website and return the content as Markdown', isEnabled: true, args: ['url', 'headers'] },
            { name: 'fetch_txt', description: 'Fetch a website, return the content as plain text (no HTML)', isEnabled: true, args: ['url', 'headers'] },
            { name: 'fetch_json', description: 'Fetch a JSON file from a URL', isEnabled: true, args: ['url', 'headers'] },
        ]
    }
]


const SettingsPage: React.FC<SettingsPageProps> = ({ onBack, quickPhrases, onUpdateQuickPhrases }) => {
  const [activeSubPage, setActiveSubPage] = useState<SubPage | null>(null);

  // --- State for Settings ---
  const [theme, setTheme] = useState('跟随系统');
  const [language, setLanguage] = useState('跟随系统');
  
  // Model Configuration State
  const [modelConfigs, setModelConfigs] = useState<Record<ModelType, ModelConfig>>({
    chat: { id: 'default', name: '使用当前对话模型', prompt: '' },
    summary: { id: 'THUDM/GLM-4-9B-0414', name: 'THUDM/GLM-4-9B-0414', prompt: '' },
    translation: { id: 'mistral', name: 'mistral', prompt: '' },
    ocr: { id: 'THUDM/GLM-4-9B-0414', name: 'THUDM/GLM-4-9B-0414', prompt: '' },
  });
  
  // Editor State for Models
  const [editingModelType, setEditingModelType] = useState<ModelType | null>(null);


  const [activeSearchProviderId, setActiveSearchProviderId] = useState('1');
  const [proxyEnabled, setProxyEnabled] = useState(false);

  // --- Assistant Management State ---
  const [assistants, setAssistants] = useState<Assistant[]>(initialAssistants);
  const [editingAssistantId, setEditingAssistantId] = useState<string | null>(null);

  // --- Provider Management State ---
  const [providers, setProviders] = useState<Provider[]>(initialProviders);
  const [editingProviderId, setEditingProviderId] = useState<string | null>(null);
  
  // --- Search Provider Management State ---
  const [searchProviders, setSearchProviders] = useState<SearchProvider[]>(initialSearchProviders);
  const [editingSearchProviderId, setEditingSearchProviderId] = useState<string | null>(null);

  // --- MCP Management State ---
  const [mcpServers, setMCPServers] = useState<MCPServer[]>(initialMCPServers);
  const [editingMCPId, setEditingMCPId] = useState<string | null>(null);
  const [isAddingMCP, setIsAddingMCP] = useState(false);

  // --- Quick Phrase Management State ---
  const [editingQuickPhraseId, setEditingQuickPhraseId] = useState<string | null>(null);
  const [isAddingQuickPhrase, setIsAddingQuickPhrase] = useState(false);

  // --- Backup State ---
  const [backupConfig, setBackupConfig] = useState({
      chatHistory: true,
      files: true,
      webdav: {
          host: '',
          username: '',
          password: ''
      }
  });
  const [isEditingWebDAV, setIsEditingWebDAV] = useState(false);


  const handleUpdateAssistant = (updated: Assistant) => {
      setAssistants(prev => prev.map(a => a.id === updated.id ? updated : a));
  };
  
  const handleUpdateProvider = (updated: Provider) => {
      setProviders(prev => prev.map(p => p.id === updated.id ? updated : p));
  }
  
  const handleUpdateSearchProvider = (updated: SearchProvider) => {
      setSearchProviders(prev => prev.map(p => p.id === updated.id ? updated : p));
  }
  
  const handleUpdateMCP = (updated: MCPServer) => {
      setMCPServers(prev => prev.map(s => s.id === updated.id ? updated : s));
  }
  
  const handleAddMCP = () => {
      const newId = Date.now().toString();
      const newServer: MCPServer = {
          id: newId,
          name: 'My MCP',
          type: 'Streamable HTTP',
          url: '',
          isEnabled: true,
          status: 'disconnected',
          isBuiltIn: false,
          tools: []
      }
      setMCPServers([...mcpServers, newServer]);
      setEditingMCPId(newId);
      setIsAddingMCP(true);
  }
  
  const handleDeleteMCP = (id: string) => {
      setMCPServers(prev => prev.filter(s => s.id !== id));
  }

  const handleAddAssistant = () => {
      const newId = Date.now().toString();
      const newAssistant: Assistant = {
          id: newId,
          name: 'New Assistant',
          avatar: 'N',
          description: '暂无提示词',
          temperature: 0.7,
          topP: 0.95,
          contextMessageCount: 10,
          maxOutputTokens: '无限制',
          useAvatar: true,
          streamOutput: true,
          chatModel: '使用全局默认',
          systemPrompt: '',
          enableMemory: false,
          enableHistoryReference: false,
          memories: [],
          quickPhrases: []
      };
      setAssistants([...assistants, newAssistant]);
      setEditingAssistantId(newId);
  };

  const handleUpdateQuickPhrase = (updated: QuickPhrase) => {
    onUpdateQuickPhrases(quickPhrases.map(p => p.id === updated.id ? updated : p));
    setEditingQuickPhraseId(null);
  };

  const handleAddQuickPhrase = () => {
      const newId = Date.now().toString();
      const newPhrase: QuickPhrase = {
          id: newId,
          phrase: '',
          shortcut: ''
      };
      onUpdateQuickPhrases([...quickPhrases, newPhrase]);
      setEditingQuickPhraseId(newId);
      setIsAddingQuickPhrase(true);
  };

  const handleDeleteQuickPhrase = (id: string) => {
      onUpdateQuickPhrases(quickPhrases.filter(p => p.id !== id));
      setEditingQuickPhraseId(null);
  };
  
  // --- Model Config Handlers ---
  const resetModelConfig = (type: ModelType) => {
      setModelConfigs(prev => ({
          ...prev,
          [type]: { ...prev[type], prompt: '', id: type === 'chat' ? 'default' : prev[type].id } // Simple reset logic
      }));
  };

  const updateModelPrompt = (prompt: string) => {
      if (editingModelType) {
          setModelConfigs(prev => ({
              ...prev,
              [editingModelType]: { ...prev[editingModelType], prompt }
          }));
      }
  };


  // --- Page Implementations ---

  const DisplayPage = () => (
    <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
      <Header title="显示" onBack={() => setActiveSubPage(null)} />
      <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar">
        <SectionGroup title="主题设置">
          <SelectionItem label="浅色" selected={theme === '浅色'} onClick={() => setTheme('浅色')} />
          <SelectionItem label="深色" selected={theme === '深色'} onClick={() => setTheme('深色')} />
          <SelectionItem label="跟随系统" selected={theme === '跟随系统'} onClick={() => setTheme('跟随系统')} />
        </SectionGroup>
        <SectionGroup title="语言设置">
          <SelectionItem label="简体中文" selected={language === '简体中文'} onClick={() => setLanguage('简体中文')} />
          <SelectionItem label="繁体中文" selected={language === '繁体中文'} onClick={() => setLanguage('繁体中文')} />
          <SelectionItem label="英文" selected={language === '英文'} onClick={() => setLanguage('英文')} />
          <SelectionItem label="跟随系统" selected={language === '跟随系统'} onClick={() => setLanguage('跟随系统')} />
        </SectionGroup>
      </main>
    </div>
  );

  const AssistantListPage = () => (
    <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
      <Header title="助手设置" onBack={() => setActiveSubPage(null)} actionIcon="add" onAction={handleAddAssistant} />
      <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar space-y-4">
        {assistants.map((assistant) => (
            <div 
                key={assistant.id}
                onClick={() => setEditingAssistantId(assistant.id)}
                className="bg-card-light dark:bg-card-dark rounded-2xl p-4 shadow-sm border border-border-light dark:border-border-dark flex items-start space-x-4 active:scale-[0.98] transition-transform cursor-pointer"
            >
                <div className="w-12 h-12 rounded-full bg-[#E4D5D5] flex items-center justify-center flex-shrink-0">
                    <span className="text-xl font-medium text-[#5E4035]">{assistant.avatar}</span>
                </div>
                <div className="flex-1 min-w-0">
                    <div className="flex items-center justify-between mb-1">
                        <span className="font-medium text-gray-900 dark:text-gray-100 text-lg">{assistant.name}</span>
                        {assistant.isDefault && (
                            <span className="px-2 py-0.5 bg-[#F2E8E8] text-[#8B5E3C] text-xs rounded-full border border-[#E4D5D5]">默认</span>
                        )}
                    </div>
                    <p className="text-sm text-text-secondary-light dark:text-text-secondary-dark line-clamp-1">
                        {assistant.description || assistant.systemPrompt || "暂无提示词"}
                    </p>
                </div>
            </div>
        ))}
      </main>
    </div>
  );

  const DefaultModelPage = () => {
    if (editingModelType) {
        return (
            <ModelPromptEditor 
                title={editingModelType === 'chat' ? '聊天模型' : editingModelType === 'summary' ? '标题总结模型' : editingModelType === 'translation' ? '翻译模型' : 'OCR 模型'}
                prompt={modelConfigs[editingModelType].prompt}
                onUpdate={updateModelPrompt}
                onBack={() => setEditingModelType(null)}
            />
        );
    }
    
    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
          <Header title="默认模型" onBack={() => setActiveSubPage(null)} />
          <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar">
            
            <ModelCard 
                icon="chat_bubble_outline" 
                title="聊天模型" 
                description="全局默认的聊天模型"
                onReset={() => resetModelConfig('chat')}
                onSettings={() => setEditingModelType('chat')}
            >
                 <button className="flex items-center space-x-2 px-3 py-2 bg-gray-100 dark:bg-gray-800 rounded-lg text-sm text-gray-700 dark:text-gray-300">
                    <span className="w-5 h-5 flex items-center justify-center bg-[#E4D5D5] text-[#5E4035] rounded-full text-xs font-bold">使</span>
                    <span>{modelConfigs.chat.name}</span>
                </button>
            </ModelCard>

            <ModelCard 
                icon="summarize" 
                title="标题总结模型" 
                description="用于总结对话标题的模型，推荐使用快速且便宜的模型"
                onReset={() => resetModelConfig('summary')}
                onSettings={() => setEditingModelType('summary')}
            >
                 <button className="flex items-center justify-between w-full px-4 py-3 bg-gray-100 dark:bg-gray-800 rounded-xl text-sm text-gray-800 dark:text-gray-200">
                    <div className="flex items-center space-x-2">
                        <span className="material-symbols-outlined text-purple-500 text-lg">hotel_class</span>
                        <span>{modelConfigs.summary.name}</span>
                    </div>
                 </button>
            </ModelCard>

            <ModelCard 
                icon="translate" 
                title="翻译模型" 
                description="用于翻译消息内容的模型，推荐使用快速且准确的模型"
                onReset={() => resetModelConfig('translation')}
                onSettings={() => setEditingModelType('translation')}
            >
                 <button className="flex items-center justify-between w-full px-4 py-3 bg-gray-100 dark:bg-gray-800 rounded-xl text-sm text-gray-800 dark:text-gray-200">
                    <div className="flex items-center space-x-2">
                        <span className="material-symbols-outlined text-orange-500 text-lg">local_fire_department</span>
                        <span>{modelConfigs.translation.name}</span>
                    </div>
                 </button>
            </ModelCard>

            <ModelCard 
                icon="image_search" 
                title="OCR 模型" 
                description="用于对图片执行文字识别的模型"
                onReset={() => resetModelConfig('ocr')}
                onSettings={() => setEditingModelType('ocr')}
            >
                 <button className="flex items-center justify-between w-full px-4 py-3 bg-gray-100 dark:bg-gray-800 rounded-xl text-sm text-gray-800 dark:text-gray-200">
                    <div className="flex items-center space-x-2">
                        <span className="material-symbols-outlined text-blue-500 text-lg">hotel_class</span>
                        <span>{modelConfigs.ocr.name}</span>
                    </div>
                 </button>
            </ModelCard>

          </main>
        </div>
      );
  };
  
  // --- Providers Page with List ---
  const ProvidersPage = () => {
      return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
          <Header title="服务商" onBack={() => setActiveSubPage(null)} actionIcon="add" />
          <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
            <div className="space-y-3">
                {providers.map((provider) => (
                    <button 
                        key={provider.id}
                        onClick={() => setEditingProviderId(provider.id)}
                        className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark rounded-xl shadow-sm border border-border-light dark:border-border-dark active:scale-[0.98] transition-transform"
                    >
                        <div className="flex items-center space-x-4">
                            <div className="w-10 h-10 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
                                {provider.icon.length === 1 ? (
                                     <span className="text-lg font-bold text-gray-700 dark:text-gray-300">{provider.icon}</span>
                                ) : (
                                     <span className="material-symbols-outlined text-gray-700 dark:text-gray-300">{provider.icon}</span>
                                )}
                            </div>
                            <span className="font-medium text-gray-900 dark:text-gray-100 text-base">{provider.name}</span>
                        </div>
                        <div className="flex items-center space-x-3">
                             <span className={`px-2 py-1 rounded text-xs font-medium ${
                                 provider.isEnabled 
                                    ? 'bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400' 
                                    : 'bg-orange-100 text-orange-700 dark:bg-orange-900/30 dark:text-orange-400'
                             }`}>
                                 {provider.isEnabled ? '启用' : '禁用'}
                             </span>
                             <span className="material-symbols-outlined text-gray-400">chevron_right</span>
                        </div>
                    </button>
                ))}
            </div>
          </main>
        </div>
      );
  };
  
  // --- Search Services Page ---
  const SearchPage = () => {
    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
          <Header title="搜索服务" onBack={() => setActiveSubPage(null)} actionIcon="add" />
          <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
            <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">搜索提供商</div>
            <div className="space-y-3">
                {searchProviders.map((provider) => (
                     <button 
                        key={provider.id}
                        onClick={() => setEditingSearchProviderId(provider.id)}
                        className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark rounded-xl shadow-sm border border-border-light dark:border-border-dark active:scale-[0.98] transition-transform"
                    >
                        <div className="flex items-center space-x-4">
                            <div className="w-10 h-10 rounded-full bg-gray-100 dark:bg-gray-800 flex items-center justify-center">
                                {provider.icon.length > 2 ? <span className="material-symbols-outlined text-gray-600 dark:text-gray-300">{provider.icon}</span> : <span className="font-bold text-gray-600 dark:text-gray-300">{provider.icon}</span>}
                            </div>
                            <span className="font-medium text-gray-900 dark:text-gray-100 text-base">{provider.name}</span>
                        </div>
                        <span className="material-symbols-outlined text-gray-400">chevron_right</span>
                    </button>
                ))}
            </div>
          </main>
        </div>
      );
  };

  const MCPListPage = () => (
    <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
      <Header title="MCP" onBack={() => setActiveSubPage(null)} actionIcon="add" onAction={handleAddMCP} secondaryActionIcon="edit" />
      <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
        <div className="space-y-3">
            {mcpServers.map(server => (
                <button 
                    key={server.id}
                    onClick={() => { setEditingMCPId(server.id); setIsAddingMCP(false); }}
                    className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark rounded-xl shadow-sm border border-border-light dark:border-border-dark active:scale-[0.98] transition-transform"
                >
                    <div className="flex items-center space-x-4">
                        <div className="w-10 h-10 rounded-xl bg-gray-100 dark:bg-gray-800 flex items-center justify-center relative">
                             <span className="text-sm font-mono font-bold text-gray-600 dark:text-gray-300">&gt;_</span>
                             {server.status === 'connected' && (
                                 <div className="absolute bottom-1 right-1 w-2.5 h-2.5 bg-green-500 rounded-full border-2 border-white dark:border-gray-800"></div>
                             )}
                        </div>
                        <div className="flex flex-col items-start">
                             <span className="font-medium text-gray-900 dark:text-gray-100 text-base mb-1">{server.name}</span>
                             <div className="flex items-center space-x-2">
                                 {server.status === 'connected' && (
                                     <span className="px-1.5 py-0.5 rounded-md bg-green-100 dark:bg-green-900/30 text-green-700 dark:text-green-400 text-[10px] font-medium border border-green-200 dark:border-green-800">已连接</span>
                                 )}
                                 {server.isBuiltIn && (
                                     <span className="px-1.5 py-0.5 rounded-md bg-[#F2E8E8] dark:bg-[#3E3E3E] text-[#8B5E3C] dark:text-[#E4D5D5] text-[10px] font-medium border border-[#E4D5D5] dark:border-[#5E4035]">内置</span>
                                 )}
                                 <span className="px-1.5 py-0.5 rounded-md bg-[#F2E8E8] dark:bg-[#3E3E3E] text-[#8B5E3C] dark:text-[#E4D5D5] text-[10px] font-medium border border-[#E4D5D5] dark:border-[#5E4035]">工具: {server.tools.filter(t => t.isEnabled).length}/{server.tools.length}</span>
                             </div>
                        </div>
                    </div>
                    <span className="material-symbols-outlined text-gray-400">chevron_right</span>
                </button>
            ))}
        </div>
      </main>
    </div>
  );

  const QuickPhrasePage = () => (
    <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
      <Header title="快捷短语" onBack={() => setActiveSubPage(null)} actionIcon="add" onAction={handleAddQuickPhrase} />
      <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar">
        <div className="space-y-3">
          {quickPhrases.map((item) => (
             <button
               key={item.id}
               onClick={() => {
                 setEditingQuickPhraseId(item.id);
                 setIsAddingQuickPhrase(false);
               }}
               className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark rounded-xl shadow-sm border border-border-light dark:border-border-dark active:scale-[0.98] transition-transform"
             >
                <div className="flex-1 min-w-0 mr-4">
                  <div className="text-base font-medium truncate text-gray-900 dark:text-gray-100 text-left">{item.phrase}</div>
                </div>
                <div className="px-2 py-1 bg-gray-100 dark:bg-gray-800 rounded-lg border border-gray-200 dark:border-gray-700">
                    <span className="text-xs font-mono font-medium text-gray-600 dark:text-gray-300">/{item.shortcut}</span>
                </div>
             </button>
          ))}
        </div>
        {quickPhrases.length === 0 && (
             <div className="flex flex-col items-center justify-center h-40 text-text-secondary-light dark:text-text-secondary-dark">
                 <p>暂无快捷短语</p>
             </div>
        )}
      </main>
    </div>
  );

  const ProxyPage = () => {
    // Local state for proxy page form
    const [config, setConfig] = useState({
        enabled: proxyEnabled,
        type: 'HTTP',
        host: '127.0.0.1',
        port: '8080',
        username: '',
        password: '',
        testUrl: 'https://www.google.com'
    });

    const updateConfig = (key: string, value: any) => {
        const newConfig = { ...config, [key]: value };
        setConfig(newConfig);
        if (key === 'enabled') {
            setProxyEnabled(value);
        }
    };

    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
            <Header title="网络代理" onBack={() => setActiveSubPage(null)} />
            <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
                <SectionGroup>
                     <ToggleItem
                        label="启动代理"
                        checked={config.enabled}
                        onChange={(v) => updateConfig('enabled', v)}
                     />
                </SectionGroup>

                <div className={`transition-all duration-300 ${config.enabled ? 'opacity-100' : 'opacity-50 pointer-events-none'}`}>
                     {/* Type */}
                     <div className="mb-4 px-1">
                        <label className="block text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2 ml-1">代理类型</label>
                        <div className="relative">
                            <select
                                value={config.type}
                                onChange={(e) => updateConfig('type', e.target.value)}
                                className="w-full appearance-none bg-card-light dark:bg-card-dark border-none rounded-2xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none pr-10"
                            >
                                <option>HTTP</option>
                                <option>HTTPS</option>
                                <option>SOCKS5</option>
                            </select>
                            <span className="absolute right-4 top-1/2 -translate-y-1/2 material-symbols-outlined text-gray-500 pointer-events-none">expand_more</span>
                        </div>
                     </div>

                     {/* Host */}
                     <div className="mb-4 px-1">
                        <label className="block text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2 ml-1">服务器地址</label>
                        <input
                            type="text"
                            value={config.host}
                            onChange={(e) => updateConfig('host', e.target.value)}
                            className="w-full bg-gray-50 dark:bg-card-dark border-none rounded-2xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="127.0.0.1"
                        />
                     </div>

                     {/* Port */}
                     <div className="mb-4 px-1">
                        <label className="block text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2 ml-1">端口</label>
                        <input
                            type="text"
                            value={config.port}
                            onChange={(e) => updateConfig('port', e.target.value)}
                            className="w-full bg-gray-50 dark:bg-card-dark border-none rounded-2xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="8080"
                        />
                     </div>

                     {/* Username */}
                     <div className="mb-4 px-1">
                        <label className="block text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2 ml-1">用户名</label>
                        <input
                            type="text"
                            value={config.username}
                            onChange={(e) => updateConfig('username', e.target.value)}
                            className="w-full bg-gray-50 dark:bg-card-dark border-none rounded-2xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="可选"
                        />
                     </div>

                     {/* Password */}
                     <div className="mb-4 px-1">
                        <label className="block text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2 ml-1">密码</label>
                        <input
                            type="password"
                            value={config.password}
                            onChange={(e) => updateConfig('password', e.target.value)}
                            className="w-full bg-gray-50 dark:bg-card-dark border-none rounded-2xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="可选"
                        />
                     </div>

                     <p className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-4 mb-8 px-2 leading-relaxed">
                        同时开启全局代理与供应商代理时，将优先使用供应商代理。
                     </p>

                     {/* Test */}
                     <h2 className="text-sm font-bold text-gray-900 dark:text-gray-100 mb-4 px-2">连接测试</h2>
                     <div className="space-y-4 px-1">
                        <input
                            type="text"
                            value={config.testUrl}
                            onChange={(e) => updateConfig('testUrl', e.target.value)}
                            className="w-full bg-gray-50 dark:bg-card-dark border-none rounded-2xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                        />
                        <button className="w-full py-3 bg-gray-200 dark:bg-gray-800 text-gray-900 dark:text-gray-100 rounded-2xl font-medium hover:bg-gray-300 dark:hover:bg-gray-700 transition-colors">
                            测试
                        </button>
                     </div>
                </div>
            </main>
        </div>
    );
  };

  const WebDAVConfigEditor = () => {
    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
            <Header title="WebDAV 设置" onBack={() => setIsEditingWebDAV(false)} />
            <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
                 <SectionGroup>
                    <div className="w-full p-4 bg-card-light dark:bg-card-dark">
                        <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">服务器地址</div>
                        <input 
                            type="text"
                            className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="https://example.com/dav"
                            value={backupConfig.webdav.host}
                            onChange={(e) => setBackupConfig({...backupConfig, webdav: {...backupConfig.webdav, host: e.target.value}})}
                        />
                    </div>
                    <div className="w-full p-4 bg-card-light dark:bg-card-dark border-t border-border-light dark:border-border-dark">
                         <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">用户名</div>
                         <input 
                            type="text"
                            className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="用户名"
                            value={backupConfig.webdav.username}
                            onChange={(e) => setBackupConfig({...backupConfig, webdav: {...backupConfig.webdav, username: e.target.value}})}
                        />
                    </div>
                     <div className="w-full p-4 bg-card-light dark:bg-card-dark border-t border-border-light dark:border-border-dark">
                         <div className="text-sm text-text-secondary-light dark:text-text-secondary-dark mb-2">密码</div>
                         <input 
                            type="password"
                            className="w-full bg-gray-50 dark:bg-gray-800 border-none rounded-xl px-4 py-3 text-gray-900 dark:text-gray-100 focus:ring-1 focus:ring-primary outline-none"
                            placeholder="密码"
                            value={backupConfig.webdav.password}
                            onChange={(e) => setBackupConfig({...backupConfig, webdav: {...backupConfig.webdav, password: e.target.value}})}
                        />
                    </div>
                 </SectionGroup>
                 <div className="mt-8">
                     <button 
                        onClick={() => setIsEditingWebDAV(false)}
                        className="w-full py-4 bg-[#8B5E3C] text-white rounded-2xl font-medium shadow-md active:scale-95 transition-transform"
                     >
                         保存
                     </button>
                 </div>
            </main>
        </div>
    )
  }

  const BackupPage = () => {
    return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
            <Header title="备份与恢复" onBack={() => setActiveSubPage(null)} />
            <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
                <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">备份管理</div>
                <SectionGroup>
                    <ToggleItem 
                        label="聊天记录" 
                        checked={backupConfig.chatHistory} 
                        onChange={(v) => setBackupConfig({...backupConfig, chatHistory: v})}
                    />
                    <ToggleItem 
                        label="文件" 
                        checked={backupConfig.files} 
                        onChange={(v) => setBackupConfig({...backupConfig, files: v})}
                    />
                </SectionGroup>

                <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">WebDAV 备份</div>
                <SectionGroup>
                    <ValueItem 
                        label="WebDAV 服务器设置" 
                        icon="settings" 
                        onClick={() => setIsEditingWebDAV(true)} 
                        isLink 
                    />
                    <ValueItem 
                        label="测试连接" 
                        icon="cable" 
                        onClick={() => alert("测试连接...")} 
                        isLink 
                    />
                     <ValueItem 
                        label="恢复" 
                        icon="download" 
                        onClick={() => alert("恢复功能暂未实现")} 
                        isLink 
                    />
                     <ValueItem 
                        label="立即备份" 
                        icon="upload" 
                        onClick={() => alert("开始备份...")} 
                        isLink 
                    />
                </SectionGroup>

                <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">本地备份</div>
                <SectionGroup>
                    <ValueItem 
                        label="导出为文件" 
                        icon="file_upload" 
                        onClick={() => alert("导出...")} 
                        isLink 
                    />
                    <ValueItem 
                        label="备份文件导入" 
                        icon="file_download" 
                        onClick={() => alert("导入...")} 
                        isLink 
                    />
                    <ValueItem 
                        label="从 Cherry Studio 导入" 
                        icon="dataset_linked" 
                        onClick={() => alert("导入...")} 
                        isLink 
                    />
                </SectionGroup>
            </main>
        </div>
    );
  }

  const PlaceholderPage = ({ title }: { title: string }) => (
    <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
        <Header title={title} onBack={() => setActiveSubPage(null)} />
        <main className="flex-1 flex items-center justify-center text-text-secondary-light dark:text-text-secondary-dark">
            <p>{title}的内容</p>
        </main>
    </div>
  );
  
  // --- About Page ---
const AboutPage = ({ onBack }: { onBack: () => void }) => {
    return (
      <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
        <Header title="关于" onBack={onBack} />
        <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
            <div className="flex flex-col items-start mb-8 px-4">
                 <div className="flex items-center space-x-4 mb-2">
                     <div className="w-16 h-16 rounded-full bg-gradient-to-tr from-blue-500 to-purple-500 flex items-center justify-center text-white">
                        <span className="material-symbols-outlined text-4xl">smart_toy</span>
                     </div>
                     <div>
                        <h1 className="text-2xl font-bold text-gray-900 dark:text-gray-100">Cometix</h1>
                        <p className="text-text-secondary-light dark:text-text-secondary-dark">开源AI 助手</p>
                     </div>
                 </div>
            </div>
            
            <SectionGroup>
                <ValueItem label="版本" value="1.1.2 / 2017" isLink onClick={() => {}} />
                <div className="flex w-full items-center justify-between p-4 bg-card-light dark:bg-card-dark">
                     <span className="text-base font-medium text-gray-900 dark:text-gray-100">系统</span>
                     <span className="text-sm text-text-secondary-light dark:text-text-secondary-dark">Android</span>
                </div>
            </SectionGroup>
  
            <SectionGroup>
                <ValueItem label="官网" icon="language" isLink onClick={() => {}} />
                <ValueItem label="GitHub" icon="code" isLink onClick={() => {}} />
                <ValueItem label="许可证" icon="description" isLink onClick={() => {}} />
            </SectionGroup>
  
            <SectionGroup>
                <ValueItem label="加入QQ群" icon="group" isLink onClick={() => {}} />
                <ValueItem label="在 Discord 中加入我们" icon="forum" isLink onClick={() => {}} />
            </SectionGroup>
        </main>
      </div>
    );
  };
  
  // --- Sponsor Page ---
  const SponsorPage = ({ onBack }: { onBack: () => void }) => {
      const sponsors = [
          { name: 'wwxiaoqi', avatar: 'https://ui-avatars.com/api/?name=ww&background=random' },
          { name: 'orange1...', avatar: 'https://ui-avatars.com/api/?name=or&background=random' },
          { name: 'meeer', avatar: 'https://ui-avatars.com/api/?name=me&background=random' },
          { name: 'Jorben', avatar: 'https://ui-avatars.com/api/?name=Jo&background=random' },
          { name: 'stou', avatar: 'https://ui-avatars.com/api/?name=st&background=random' },
          { name: 'Gordon', avatar: 'https://ui-avatars.com/api/?name=Go&background=random' },
          { name: '阳月🌙', avatar: 'https://ui-avatars.com/api/?name=YY&background=random' },
          { name: 'JaqenZe', avatar: 'https://ui-avatars.com/api/?name=Ja&background=random' },
          { name: 'thinking', avatar: 'https://ui-avatars.com/api/?name=th&background=random' },
          { name: '昼月无寂', avatar: 'https://ui-avatars.com/api/?name=ZY&background=random' },
      ];
  
      return (
        <div className="flex flex-col h-full animate-fade-in bg-background-light dark:bg-black">
          <Header title="赞助" onBack={onBack} />
          <main className="flex-1 overflow-y-auto px-4 pt-6 no-scrollbar pb-8">
              <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">赞助方式</div>
              <SectionGroup>
                  <ValueItem label="爱发电" icon="favorite" isLink onClick={() => {}} />
                  <ValueItem label="微信赞助" icon="link" isLink onClick={() => {}} />
              </SectionGroup>
              
              <div className="mb-4 text-xs font-medium text-text-secondary-light dark:text-text-secondary-dark px-4 uppercase tracking-wide">赞助用户</div>
              <div className="grid grid-cols-4 gap-4 px-2">
                  {sponsors.map((user, idx) => (
                      <div key={idx} className="flex flex-col items-center">
                          <img src={user.avatar} alt={user.name} className="w-14 h-14 rounded-full mb-2 bg-gray-200 object-cover" />
                          <span className="text-xs text-center text-text-secondary-light dark:text-text-secondary-dark truncate w-full">{user.name}</span>
                      </div>
                  ))}
              </div>
          </main>
        </div>
      );
  };

  // --- Main Settings List ---

  const MainSettings = () => {
    const sections: SettingsSection[] = [
      {
        title: "通用",
        items: [
          // "Color Mode" removed as requested
          { icon: "desktop_windows", label: "显示", value: theme, onClick: () => setActiveSubPage('display') },
          { icon: "smart_toy", label: "助手", onClick: () => setActiveSubPage('assistant') },
        ]
      },
      {
        title: "模型与服务",
        items: [
          { icon: "favorite", label: "默认模型", value: modelConfigs.chat.name, onClick: () => setActiveSubPage('default_model') },
          { icon: "schema", label: "服务商", onClick: () => setActiveSubPage('providers') },
          { icon: "travel_explore", label: "搜索服务", value: searchProviders.find(p => p.id === activeSearchProviderId)?.name || 'Google', onClick: () => setActiveSubPage('search') },
          { icon: "data_array", label: "MCP", onClick: () => setActiveSubPage('mcp') },
          { icon: "bolt", label: "快捷短语", onClick: () => setActiveSubPage('quick_phrase') },
          { icon: "chat", label: "网络代理", value: proxyEnabled ? "开" : "关", onClick: () => setActiveSubPage('proxy') },
        ]
      },
      {
        title: "数据",
        items: [
          { icon: "database", label: "备份", onClick: () => setActiveSubPage('backup') },
          { icon: "folder_managed", label: "聊天存储", subtitle: "0 文件 • 0 B", onClick: () => setActiveSubPage('chat_storage') },
        ]
      },
      {
        title: "其他设置",
        items: [
          { icon: "info", label: "关于", onClick: () => setActiveSubPage('about') },
          { icon: "description", label: "使用文档", onClick: () => setActiveSubPage('docs') },
          { icon: "volunteer_activism", label: "赞助", onClick: () => setActiveSubPage('sponsor') },
        ]
      }
    ];

    return (
      <div className="flex flex-col h-full w-full bg-background-light dark:bg-black text-text-primary-light dark:text-text-primary-dark overflow-hidden animate-fade-in">
        <header className="flex items-center px-4 py-4 bg-background-light dark:bg-background-dark border-b border-gray-100 dark:border-gray-800 shrink-0 sticky top-0 z-10">
          <button onClick={onBack} className="p-2 -ml-2 rounded-full hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors">
              <span className="material-symbols-outlined text-2xl text-gray-800 dark:text-gray-200">arrow_back</span>
          </button>
          <h1 className="ml-2 text-xl font-medium text-gray-900 dark:text-gray-100">设置</h1>
        </header>

        <main className="flex-1 overflow-y-auto px-4 pb-8 space-y-6 pt-6 no-scrollbar">
          {sections.map((section, idx) => (
            <section key={idx}>
              <h2 className="text-sm font-medium text-text-secondary-light dark:text-text-secondary-dark mb-2 px-4 uppercase tracking-wide">
                {section.title}
              </h2>
              <div className="bg-card-light dark:bg-card-dark rounded-2xl shadow-sm border border-border-light dark:border-border-dark overflow-hidden flex flex-col divide-y divide-border-light dark:divide-border-dark">
                {section.items.map((item, itemIdx) => (
                  <button 
                    key={itemIdx}
                    onClick={item.onClick}
                    className="flex w-full items-center p-4 text-left transition-colors hover:bg-black/5 dark:hover:bg-white/5 active:bg-black/10 dark:active:bg-white/10 outline-none"
                  >
                    <span className="material-symbols-outlined text-text-secondary-light dark:text-text-secondary-dark">
                      {item.icon}
                    </span>
                    <div className="ml-4 flex-1 min-w-0">
                      <div className="text-base font-medium truncate text-gray-900 dark:text-gray-100">{item.label}</div>
                      {item.subtitle && (
                         <div className="text-xs text-text-secondary-light dark:text-text-secondary-dark mt-0.5 truncate">{item.subtitle}</div>
                      )}
                    </div>
                    {item.value && (
                      <span className="text-sm text-text-secondary-light dark:text-text-secondary-dark mr-2 flex-shrink-0">
                        {item.value}
                      </span>
                    )}
                    <span className="material-symbols-outlined text-xl text-text-secondary-light dark:text-text-secondary-dark opacity-50 flex-shrink-0">
                      chevron_right
                    </span>
                  </button>
                ))}
              </div>
            </section>
          ))}
        </main>
      </div>
    );
  };

  // --- Router Switch ---
  
  if (isEditingWebDAV) {
      return <WebDAVConfigEditor />;
  }

  // 1. Assistant Editor
  if (activeSubPage === 'assistant' && editingAssistantId) {
      return (
          <AssistantEditor 
            assistantId={editingAssistantId} 
            assistants={assistants}
            onUpdate={handleUpdateAssistant}
            onBack={() => setEditingAssistantId(null)} 
          />
      );
  }
  
  // 2. Provider Detail Editor
  if (activeSubPage === 'providers' && editingProviderId) {
      const provider = providers.find(p => p.id === editingProviderId);
      if (provider) {
          return (
              <ProviderDetailEditor 
                  provider={provider}
                  onUpdate={handleUpdateProvider}
                  onBack={() => setEditingProviderId(null)}
              />
          )
      }
  }

  // 3. Search Provider Detail Editor
  if (activeSubPage === 'search' && editingSearchProviderId) {
      const provider = searchProviders.find(p => p.id === editingSearchProviderId);
      if (provider) {
          return (
              <SearchProviderDetailEditor
                  provider={provider}
                  onUpdate={handleUpdateSearchProvider}
                  onBack={() => setEditingSearchProviderId(null)}
              />
          )
      }
  }
  
  // 4. MCP Editor
  if (activeSubPage === 'mcp' && editingMCPId) {
      const server = mcpServers.find(s => s.id === editingMCPId);
      if (server) {
          return (
              <MCPEditor 
                  server={server}
                  isNew={isAddingMCP}
                  onUpdate={handleUpdateMCP}
                  onBack={() => { setEditingMCPId(null); setIsAddingMCP(false); }}
                  onDelete={handleDeleteMCP}
              />
          )
      }
  }

  // 5. Quick Phrase Editor
  if (activeSubPage === 'quick_phrase' && editingQuickPhraseId) {
    const phrase = quickPhrases.find(p => p.id === editingQuickPhraseId);
    if (phrase) {
        return (
            <QuickPhraseEditor 
                phrase={phrase}
                isNew={isAddingQuickPhrase}
                onSave={handleUpdateQuickPhrase}
                onBack={() => { setEditingQuickPhraseId(null); setIsAddingQuickPhrase(false); }}
                onDelete={handleDeleteQuickPhrase}
            />
        )
    }
  }

  switch (activeSubPage) {
    case 'display': return <DisplayPage />;
    case 'assistant': return <AssistantListPage />;
    case 'default_model': return <DefaultModelPage />;
    case 'providers': return <ProvidersPage />;
    case 'search': return <SearchPage />;
    case 'mcp': return <MCPListPage />;
    case 'quick_phrase': return <QuickPhrasePage />;
    case 'proxy': return <ProxyPage />;
    case 'backup': return <BackupPage />;
    case 'chat_storage': return <PlaceholderPage title="聊天存储" />;
    case 'about': return <AboutPage onBack={() => setActiveSubPage(null)} />;
    case 'docs': return <PlaceholderPage title="使用文档" />;
    case 'sponsor': return <SponsorPage onBack={() => setActiveSubPage(null)} />;
    default: return <MainSettings />;
  }
};

export default SettingsPage;
