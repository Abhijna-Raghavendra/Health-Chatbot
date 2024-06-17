# load_data.py

from langchain.document_loaders import DirectoryLoader, PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import MongoDBAtlasVectorSearch
from pymongo import MongoClient
import os
from dotenv import load_dotenv

load_dotenv()
def load_pdf(data_dir):
    loader = DirectoryLoader(data_dir, glob="*.pdf", loader_cls=PyPDFLoader)
    documents = loader.load()
    return documents

def text_split(extracted_data):
    text_splitter = RecursiveCharacterTextSplitter(chunk_size=500, chunk_overlap=20)
    text_chunks = text_splitter.split_documents(extracted_data)
    return text_chunks

def setup_embeddings():
    embeddings = HuggingFaceEmbeddings(model_name="sentence-transformers/all-MiniLM-L6-v2")
    return embeddings

def setup_mongodb():
    MONGO_URI = os.environ['MONGO_URI']
    DB_NAME = "rockingpenny4"
    COLLECTION_NAME = "health"

    client = MongoClient(MONGO_URI)
    db = client[DB_NAME]
    collection = db["health"]

    return collection

def store_in_mongodb(text_chunks, embeddings, collection):
    if collection.count_documents({}) > 0:
     print("Data already present in the database. Skipping storage.")
     return None

    vector_search = MongoDBAtlasVectorSearch.from_documents(text_chunks, embeddings, collection=collection)
    return vector_search

extracted_data = load_pdf("data/")
text_chunks = text_split(extracted_data)
embeddings = setup_embeddings()
collection = setup_mongodb()
vector_search = store_in_mongodb(text_chunks, embeddings, collection)
