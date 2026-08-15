import streamlit as st
from KQLQueryBackend import KQLQueryHandler
from RAGParameters import Parameters
from datetime import datetime

st.title("KQL Query Crafter")
st.set_page_config(page_title="KQL Query Crafter",page_icon="💻", layout="wide")
st.divider()

user_prompt = st.text_input("Describe your scenario to query:", placeholder="Scenario goes here...")
st.caption("Query will be generated when scenario is provided (Be as specific as possible)")

is_querying = False
user_button = st.button("Generate Query", disabled=is_querying)

st.divider()
user_response = ""

parameters = Parameters()
kql_query_handler = KQLQueryHandler(parameters)

if user_button or user_prompt.strip() != "":
    
    st.write("STARTED QUERY AT: ", "```", datetime.now().strftime("%H:%M:%S"), "```")
    with st.spinner("Generating query..."):
        is_querying = True
        user_response = kql_query_handler.AskQuestion(user_prompt)
        is_querying = False
    with st.chat_message("ai"):
        st.subheader(user_response)
        st.caption("AI may make mistakes. Please double check your responses.")
    st.write("ENDED QUERY AT: ", "```", datetime.now().strftime("%H:%M:%S"), "```")
