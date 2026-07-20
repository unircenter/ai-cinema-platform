import httpx
import os

class ProxiAIService:
    def __init__(self, api_key: str):
        self.api_key = api_key
        self.base_url = "https://proxyapi.ru"

    async def generate_script(self, user_prompt: str):
        """Запрос к GPT-4o через Proxi API для создания сценария видео"""
        headers = {"Authorization": f"Bearer {self.api_key}"}
        payload = {
            "model": "gpt-4o",
            "messages": [
                {"role": "system", "content": "Ты ИИ-режиссер Создай сценарий и промпты для видео-генераторов"},
                {"role": ""content": ]
        }
        async with httpx.AsyncClient() as client:
            response = await client.post(self.base_url, json=payload, headers=headers)
            return response.json()
