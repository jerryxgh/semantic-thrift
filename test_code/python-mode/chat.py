import openai
# Get OpenAI API key at https://platform.openai.com/account/api-keys
openai.api_key = "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"

completion = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[{"role": "user", "content": "Hello ChatGPT!"}]
)

print(completion.choices[0].message.content)
