import React from 'react';
import { View } from '../types';

interface SidebarProps {
  isOpen: boolean;
  onClose: () => void;
  onNavigate: (view: View) => void;
}

const Sidebar: React.FC<SidebarProps> = ({ isOpen, onClose, onNavigate }) => {
  return (
    <>
      {/* Backdrop */}
      {isOpen && (
        <div 
          className="fixed inset-0 bg-black/50 z-40 transition-opacity" 
          onClick={onClose}
        />
      )}
      
      {/* Sidebar Content */}
      <aside 
        className={`fixed top-0 left-0 w-4/5 max-w-xs h-full bg-background-light dark:bg-background-dark z-50 transform transition-transform duration-300 ease-in-out flex flex-col pt-4 px-4 shadow-xl ${
          isOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        {/* Search Bar */}
        <div className="flex-none mb-6 mt-12">
          <div className="flex items-center space-x-4">
            <div className="flex-1 relative">
              <span className="material-icons absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 dark:text-gray-500">search</span>
              <input 
                className="w-full bg-gray-100 dark:bg-gray-800 border-none rounded-full py-3 pl-12 pr-4 text-gray-900 dark:text-gray-100 placeholder-gray-500 dark:placeholder-gray-400 focus:ring-2 focus:ring-primary outline-none" 
                placeholder="搜索历史记录" 
                type="text" 
              />
            </div>
            <button className="text-gray-600 dark:text-gray-400">
              <span className="material-icons text-3xl">history</span>
            </button>
          </div>
        </div>

        {/* Navigation List */}
        <nav className="flex-grow space-y-2 overflow-y-auto no-scrollbar">
          {/* Active Item */}
          <div className="flex items-center justify-between p-3 rounded-2xl bg-gray-100 dark:bg-gray-800 cursor-pointer">
            <div className="flex items-center space-x-4">
              <div className="w-10 h-10 rounded-full bg-primary flex items-center justify-center">
                <span className="text-xl font-medium text-gray-700">D</span>
              </div>
              <span className="font-medium text-gray-800 dark:text-gray-200">默认助手</span>
            </div>
            <span className="material-icons text-gray-600 dark:text-gray-400">expand_less</span>
          </div>

          {/* Other Items */}
          <div className="flex items-center justify-between p-3 rounded-2xl hover:bg-gray-50 dark:hover:bg-gray-900 cursor-pointer transition-colors">
            <div className="flex items-center space-x-4">
              <div className="w-10 h-10 rounded-full bg-primary flex items-center justify-center">
                <span className="text-xl font-medium text-gray-700">D</span>
              </div>
              <span className="font-medium text-gray-800 dark:text-gray-200">默认助手</span>
            </div>
            <span className="material-icons text-gray-600 dark:text-gray-400">edit</span>
          </div>

          <div className="flex items-center justify-between p-3 rounded-2xl hover:bg-gray-50 dark:hover:bg-gray-900 cursor-pointer transition-colors">
            <div className="flex items-center space-x-4">
              <div className="w-10 h-10 rounded-full bg-primary flex items-center justify-center">
                <span className="text-xl font-medium text-gray-700">S</span>
              </div>
              <span className="font-medium text-gray-800 dark:text-gray-200">示例助手</span>
            </div>
            <span className="material-icons text-gray-600 dark:text-gray-400">edit</span>
          </div>
        </nav>

        {/* Bottom Section */}
        <div className="flex-none py-6 border-t border-gray-100 dark:border-gray-800">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-4">
              <div className="w-10 h-10 rounded-full bg-primary flex items-center justify-center">
                <span className="text-xl font-medium text-gray-700">U</span>
              </div>
              <span className="text-lg font-medium text-gray-800 dark:text-gray-200">用户</span>
            </div>
            <div className="flex items-center space-x-4">
              <button className="text-gray-600 dark:text-gray-400 p-2 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-full">
                <span className="material-icons text-2xl">translate</span>
              </button>
              <button 
                onClick={() => {
                  onNavigate('settings');
                  onClose();
                }}
                className="text-gray-600 dark:text-gray-400 p-2 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-full"
              >
                <span className="material-icons text-2xl">settings</span>
              </button>
            </div>
          </div>
        </div>
        
        {/* Handle Indicator (Visual only, usually for drawers) */}
        <div className="w-full flex justify-center pb-3">
          <div className="w-36 h-1.5 bg-gray-200 dark:bg-gray-700 rounded-full"></div>
        </div>
      </aside>
    </>
  );
};

export default Sidebar;