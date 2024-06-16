# chat.py

from flask import request, jsonify
from langchain.prompts import PromptTemplate
from langchain.llms import CTransformers
from langchain.chains import RetrievalQA
from langchain.vectorstores import MongoDBAtlasVectorSearch
from pymongo import MongoClient
import os,sys

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../..')))

from server.utils.load_data import text_chunks, embeddings

MONGO_URI = os.environ['MONGO_URI']
DB_NAME = "rockingpenny4"
COLLECTION_NAME = "health"

client = MongoClient(MONGO_URI)
db = client[DB_NAME]
collection = db[COLLECTION_NAME]

vector_search = MongoDBAtlasVectorSearch(text_chunks,embeddings,collection=collection)

prompt_template = """
Use the following pieces of information to answer the user's question.
If you don't know the answer, just say that you don't know, don't try to make up an answer.

Context: {context}
Question: {question}

Only return the helpful answer below and nothing else.
Helpful answer:
"""
PROMPT = PromptTemplate(template=prompt_template, input_variables=["context", "question"])

llm = CTransformers(model="model/llama-2-7b-chat.ggmlv3.q4_0.bin",
                    model_type="llama",
                    config={'max_new_tokens': 512, 'temperature': 0.8})

qa = RetrievalQA.from_chain_type(llm=llm,
                                 chain_type="stuff",
                                 retriever=vector_search.as_retriever(search_kwargs={'k': 2}),
                                 return_source_documents=True,
                                 chain_type_kwargs={"prompt": PROMPT})


def chat_response(user_input):
    result = qa({"query": user_input})
    response = {"response": result["result"]}
    return response

def chat():
    data = request.get_json()
    user_input = data.get('query', '')
    response = chat_response(user_input)
    return jsonify(response)


