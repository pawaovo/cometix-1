
export interface Message {
  role: 'user' | 'model';
  text: string;
}

export interface ChatSession {
  id: string;
  title: string;
  messages: Message[];
}

export type View = 'home' | 'settings';

export interface Assistant {
  id: string;
  name: string;
  avatar: string; // letter
  description?: string;
  isDefault?: boolean;
  
  // Basic Settings
  temperature: number;
  topP: number;
  contextMessageCount: number;
  thinkingBudget?: number;
  maxOutputTokens: string | number; // 'unlimited' or number
  useAvatar: boolean;
  streamOutput: boolean;
  chatModel: string;
  
  // Prompt Settings
  systemPrompt: string;
  
  // Memory Settings
  enableMemory: boolean;
  enableHistoryReference: boolean;
  memories: string[];
  
  // Quick Phrases
  quickPhrases: string[];
}

export interface Provider {
  id: string;
  name: string;
  type: string; // 'OpenAI' | 'Google' etc
  isEnabled: boolean;
  icon: string; // char or icon name
  description?: string;
  
  // Detail Settings
  apiKey?: string;
  baseUrl?: string;
  apiPath?: string;
  models: string[];
  isMultiKey?: boolean;
  responseApi?: boolean;
}

export interface SearchProvider {
  id: string;
  name: string;
  icon: string;
  type: 'local' | 'api';
  apiKey?: string;
  maxResults: number;
  timeout: number;
  isConnected?: boolean;
}

export interface MCPTool {
  name: string;
  description: string;
  isEnabled: boolean;
  args: string[];
}

export interface MCPServer {
  id: string;
  name: string;
  type: 'Streamable HTTP' | 'SSE';
  url: string;
  isEnabled: boolean;
  status: 'connected' | 'disconnected' | 'error';
  isBuiltIn?: boolean;
  tools: MCPTool[];
  headers?: { key: string; value: string }[];
}

export interface QuickPhrase {
  id: string;
  phrase: string;
  shortcut: string;
}

export interface SettingsItem {
  icon: string;
  label: string;
  value?: string;
  subtitle?: string;
  isLink?: boolean;
  onClick?: () => void;
  type?: 'toggle' | 'link' | 'value';
}

export interface SettingsSection {
  title: string;
  items: SettingsItem[];
}

export interface SettingsPageProps {
  onBack: () => void;
  quickPhrases: QuickPhrase[];
  onUpdateQuickPhrases: (phrases: QuickPhrase[]) => void;
}

export interface ChatScreenProps {
  onMenuClick: () => void;
  onNavigate: (view: View) => void;
  quickPhrases: QuickPhrase[];
}
