import streamlit as st
from KQLQueryBackend import KQLQueryHandler
from RAGParameters import Parameters
from datetime import datetime

st.title("KQL Query")
st.divider()


user_prompt = st.text_input("Describe your scenario to query:", placeholder="Scenario goes here...")
st.caption("Query will be generated when scenario is provided")

is_querying = False
user_button = st.button("Generate Query", disabled=is_querying)

st.divider()
user_response = ""

parameters = Parameters()
kql_query_handler = KQLQueryHandler(parameters)




if user_button or user_prompt.strip() != "":
    is_querying = True
    st.write(datetime.now())
    with st.spinner("Generating query..."):
        user_response = kql_query_handler.AskQuestion(user_prompt)
    with st.chat_message("ai"):
        st.header("Query:")
        st.subheader(user_response)
    is_querying = False
    st.write(datetime.now())
