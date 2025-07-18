import discord
from discord import app_commands
from discord.ext import commands
import asyncio

intents = discord.Intents.default()
intents.message_content = True

bot = commands.Bot(command_prefix="!", intents=intents)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user} (ID: {bot.user.id})')
    print('------')
    try:
        synced = await bot.tree.sync()
        print(f"Synced {len(synced)} command(s)")
    except Exception as e:
        print(e)

@bot.tree.command(name="delete_webhook", description="delete webhook")
@app_commands.describe(
    webhook_url="webhook URL",
    reason="reason(Selectable)"
)
async def delete_webhook(interaction: discord.Interaction, webhook_url: str, reason: str = None):
    try:
        if not webhook_url.startswith(("https://discord.com/api/webhooks/", "https://canary.discord.com/api/webhooks/")):
            await interaction.response.send_message("invalid webhook URL", ephemeral=True)
            return
            
        webhook = discord.Webhook.from_url(webhook_url, session=bot.http._HTTPClient__session)

        await webhook.delete(reason=reason)
        await interaction.response.send_message(f"✅ Webhook Delete！{'reason: ' + reason if reason else ''}", ephemeral=True)
        
    except discord.NotFound:
        await interaction.response.send_message("❌ not found webhook", ephemeral=True)
    except discord.Forbidden:
        await interaction.response.send_message("❌ forbidden delete webhook", ephemeral=True)
    except Exception as e:
        await interaction.response.send_message(f"❌ webhook failed to be deleted: {str(e)}", ephemeral=True)

@bot.tree.command(name="spam_webhook", description="spam channel")
@app_commands.describe(
    webhook_url="webhook URL",
    message="message",
    amount="amount(1-1000)",
    delay="delay(second)"
)
async def spam_webhook(interaction: discord.Interaction, webhook_url: str, message: str, amount: int = 5, delay: float = 1.0):
    try:
        if not webhook_url.startswith(("https://discord.com/api/webhooks/", "https://canary.discord.com/api/webhooks/")):
            await interaction.response.send_message("❌ invalid webhook URL", ephemeral=True)
            return
            
        if amount < 1 or amount > 1000:
            await interaction.response.send_message("❌ number of sending times must be between 1 and 1000", ephemeral=True)
            return
            
        if delay < 0 or delay > 5:
            await interaction.response.send_message("❌ delay time must be between 0-5 seconds", ephemeral=True)
            return
            
        await interaction.response.send_message(f"⏳ Start sending to webhook {amount} messages...", ephemeral=True)
        
        webhook = discord.Webhook.from_url(webhook_url, session=bot.http._HTTPClient__session)
        
        for i in range(amount):
            try:
                await webhook.send(content=f"{message} ({i+1}/{amount})")
                if i < amount - 1 and delay > 0:
                    await asyncio.sleep(delay)
            except Exception as e:
                await interaction.followup.send(f"❌ send message failed: {str(e)}", ephemeral=True)
                return
                
        await interaction.followup.send(f"✅ success send to webhook {amount}message！", ephemeral=True)
        
    except discord.NotFound:
        await interaction.response.send_message("❌ not found webhook", ephemeral=True)
    except Exception as e:
        await interaction.response.send_message(f"❌ an error occurred while sending the webhook message: {str(e)}", ephemeral=True)

# your bot token
bot.run("")
