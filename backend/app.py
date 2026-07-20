from fastapi import FastAPI, Request
from ai_services import ProxiAIService

app = FastAPI()
# В реальности ключ берется из GitHub Secrets или .env
ai_service = ProxiAIService(api_key="YOUR_PROXI_API_KEY")

@app.post("/pay-premium")
async def process_payment(user_id: int, amount: float = 500.0):
    """Логика распределения MLM-комиссий: 15%, 10%, 5%"""
    # Эмуляция: получение спонсоров из БД
    rewards = {
        "level_1": amount * 0.15, # 75 руб
        "level_2": amount * 0.10, # 50 руб
        "level_3": amount * 0.05  # 25 руб
    }
    # Здесь должен быть код записи в PostgreSQL таблицу transactions
    return {"status": "success", "distributed": rewards}

@app.post("/generate-idea")
async def ai_idea(prompt: str):
    return await ai_service.generate_script(prompt)
