<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a id="readme-top"></a>
<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Issues][issues-shield]][issues-url]
[![MIT][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <!-- <a href="https://www.flaticon.com/free-icons/viewpoint" title="viewpoint icons">Viewpoint icons created by VectorPortal - Flaticon</a> -->
  <a href="https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter">
    <img src="logo.png" alt="Logo" width="80" height="80">
  </a>

<h1 align="center">KQL Query Crafter</h3>

  <p align="center">
    A Local LLM Designed To Assist In Incident Response Situations Involving The Kibana Query Language (KQL)
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




Here's a blank template to get started. To avoid retyping too much info, do a search and replace with your text editor for the following: `ChristianLunaSaucedo`, `KQL-Query-Crafter`, `twitter_handle`, `christian-luna-saucedo`, `gmail`, `christianlunasaucedo`, `KQL Query Crafter`, `project_description`, `MIT`

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With
* [![Python][Python]][Python-url]
* [![Ollama][Ollama]][Ollama-url]



<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

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

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

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
- [ ] Add Advanced Kibana Query Language (KQL) Comprehension
    - [ ] RAG Reranking
    - [ ] Additional Markdown Files For More Context

See the [open issues](https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Top contributors:

<a href="https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=ChristianLunaSaucedo/KQL-Query-Crafter" alt="contrib.rocks image" />
</a>



<!-- LICENSE -->
## License

Distributed under the MIT. See `LICENSE.txt` for more information.

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



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[issues-shield]: https://img.shields.io/github/issues/ChristianLunaSaucedo/KQL-Query-Crafter.svg?style=for-the-badge
[issues-url]: https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter/issues
[license-shield]: https://img.shields.io/github/license/ChristianLunaSaucedo/KQL-Query-Crafter.svg?style=for-the-badge
[license-url]: https://github.com/ChristianLunaSaucedo/KQL-Query-Crafter/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/christian-luna-saucedo
[product-screenshot]: images/screenshot.png
<!-- Shields.io badges. You can a comprehensive list with many more badges at: https://github.com/inttter/md-badges -->
[Python]: https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=fff
[Python-url]: https://www.python.org/ 
[Ollama]: https://img.shields.io/badge/Ollama-fff?logo=ollama&logoColor=000
[Ollama-url]: https://ollama.com/


