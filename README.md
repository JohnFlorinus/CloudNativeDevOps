<h1 align="center">☁️ Azure CI/CD & Bicep IAC</h1>

<p align="center">
  <strong>Full-stack ToDo application deployed to Azure using Docker, Bicep, and Azure Pipelines</strong><br>
  <em>Developed as part of a school assignment where I handled the DevOps implementation.</em>
</p>

---

<h2>📘 Project Overview</h2>

<p>
This repository demonstrates a complete DevOps workflow for a containerized full-stack application.
The setup automates <strong>build, push, and deployment</strong> processes using <strong>Azure Pipelines</strong> and provisions cloud resources with <strong>Bicep (Infrastructure as Code)</strong>.
</p>

<p>
The system consists of three main components:
<ul>
  <li><strong>.NET API</strong></li>
  <li><strong>MVC Website</strong></li>
  <li><strong>MSSQL Database</strong></li>
</ul>
Frontend and backend are deployed through Azure Container Registry (ACR) and hosted as Azure Container Apps.
Database is managed through Entity Framework Code-First and is separated from the pipeline.
</p>

---

<h2>⚙️ Azure Pipeline (CI/CD)</h2>

<p>
The file <code>azure-pipelines.yml</code> defines an automated pipeline that:
</p>

<ul>
  <li>Builds the frontend and backend Docker images.</li>
  <li>Tags each image with both <code>latest</code> and the build ID.</li>
  <li>Pushes the images to <strong>Azure Container Registry</strong>.</li>
</ul>

<p>
This setup enables a reliable and repeatable deployment process. The pipeline remains intentionally lightweight without multi-stage or unit testing implementation since the project’s was scope is small and experimental.
</p>

---

<h2>🏗️ Infrastructure as Code (Bicep)</h2>

<p>
The infrastructure is defined using modular <strong>Bicep</strong> files with <code>main.bicep</code> orchestrating the creation of:
</p>

<ul>
  <li>🧱 Resource Group</li>
  <li>💾 Azure SQL Server & Database</li>
  <li>🐋 Azure Container Registry (ACR)</li>
  <li>🚀 Container Apps Environment + Container Apps</li>
</ul>

<p>
The use of separate modules ensures clarity and clean separation of concern.
</p>

---

<h2>🌐 Deployment Workflow</h2>

<ol>
  <li>Code is pushed to <code>master</code> branch → triggers the pipeline.</li>
  <li>Azure Pipeline builds and pushes Docker images to ACR.</li>
  <li>Container Apps pull the latest images from ACR → the application goes live.</li>
</ol>