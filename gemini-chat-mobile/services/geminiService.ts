import { GoogleGenAI } from "@google/genai";
import { Message } from '../types';

const getAiClient = () => {
  const apiKey = process.env.API_KEY;
  if (!apiKey) {
    console.error("API_KEY is missing");
    return null;
  }
  return new GoogleGenAI({ apiKey });
};

export const sendMessageToGemini = async (
  history: Message[],
  newMessage: string,
  onStream: (chunk: string) => void
): Promise<string> => {
  const ai = getAiClient();
  if (!ai) return "错误：缺少 API Key。";

  try {
    const chat = ai.chats.create({
      model: 'gemini-2.5-flash',
      history: history.map(msg => ({
        role: msg.role,
        parts: [{ text: msg.text }]
      })),
    });

    const result = await chat.sendMessageStream({ message: newMessage });
    
    let fullText = "";
    for await (const chunk of result) {
      const text = chunk.text;
      if (text) {
        fullText += text;
        onStream(text);
      }
    }
    return fullText;

  } catch (error) {
    console.error("Gemini API Error:", error);
    return "抱歉，处理您的请求时遇到错误。";
  }
};