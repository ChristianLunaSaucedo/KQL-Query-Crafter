<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->





<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://www.flaticon.com/free-icons/viewpoint" title="viewpoint icons">Viewpoint icons created by VectorPortal - Flaticon</a> -->
  <a href="https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter">
    <img src="logo.png" alt="Logo" width="80" height="80">
  </a>

<h1 align="center">KQL Query Crafter</h3>

  <p align="center">
    A local, AI-powered tool built for Incident Responders that translates natural language scenarios into production-ready Kibana log queries.
    <br />
    <a href="https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter">View Demo</a>
    &middot;
    <a href="https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    &middot;
    <a href="https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#background-information">Background Information</a></li>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<img width="3840" height="2160" alt="image" src="https://github.com/user-attachments/assets/16e3a265-2354-47e7-b75e-ba818d7d541b" />


<!-- ABOUT THE PROJECT -->
## About The Project





<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Background Information
* Writing Kibana queries during an incident can be tedious and slow, so this tool cuts out the syntax headaches and lets you find the logs you need by simply typing your scenario in plain English. The entire project runs locally, ensuring data privacy all around.
### Built With
* [![Python][Python]][Python-url]
* [![Ollama][Ollama]][Ollama-url]
* [![Langchain][Langchain]][Langchain-url]


<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* uv
  ```sh
  pip install uv
  ```
* ollama
  ```sh
  https://ollama.com/download
  ```

### Installation

1. Install The Generation + Embedding Ollama Models
   ```sh
   ollama pull granite4.1:8b
   ollama pull hf.co/SandLogicTechnologies/granite-embedding-311m-multilingual-r2-GGUF:IQ4_NL
   ```
2. Clone the repo
   ```sh
   git clone https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter.git
   ```
3. Create A Virtual Environment and Install Project Dependencies
   ```sh
   uv pip install -r requirements.txt
   ```
4. Create The Custom Generation Model
   ```sh
   ollama create kibana-ai -f Modelfile.txt
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

* Launch The Webpage To Get Started
  ```sh
  streamlit run scripts/main.py
  ```
  

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Add Basic Kibana Query Language (KQL) Comprehension
- [x] Add Basic Frontend
- [ ] Add Copy Query Button
- [ ] Add Improved Styling To Frontend
- [ ] Add Advanced Kibana Query Language (KQL) Comprehension To Mitigate Hallucinations
    - [ ] RAG Reranking
    - [ ] Additional Markdown Files For More Context
    - [ ] Improved Modelfile

See the [open issues](https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".


1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@ChristianLunaSaucedo](https://linkedin.com/in/christian-luna-saucedo) - christianlunasaucedo@gmail.com

Project Link: [https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter](https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Ollama Models](https://ollama.com/search)


<p align="right">(<a href="#readme-top">back to top</a>)</p>




[Python]: https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=fff
[Python-url]: https://www.python.org/ 
[Ollama]: https://img.shields.io/badge/Ollama-fff?logo=ollama&logoColor=000
[Ollama-url]: https://ollama.com/
[Langchain]: https://img.shields.io/badge/LangChain-1c3c3c.svg?logo=langchain&logoColor=white
[Langchain-url]: https://www.langchain.com/


