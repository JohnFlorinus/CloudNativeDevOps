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
The system consists of two main components:
<ul>
  <li><strong>.NET API</strong></li>
  <li><strong>MVC Website</strong></li>
  <li><strong>MSSQL Database</strong></li>
</ul>
Both are deployed through Azure Container Registry (ACR) and hosted as Azure Container Apps.
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
  <li>Runs on Ubuntu agents using <strong>Azure DevOps</strong>.</li>
</ul>

<p>
This ensures both services are automatically rebuilt and pushed to ACR whenever changes are committed to the main branch.
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

---

<p>
This project demonstrates my skills in <strong>DevOps automation</strong>, <strong>Azure Cloud architecture</strong>, and <strong>Infrastructure as Code (IaC)</strong>.
</p>

---

<h2>🧰 Technologies Used</h2>

<table>
  <tr><th>Category</th><th>Tools / Services</th></tr>
  <tr><td>CI/CD</td><td>Azure Pipelines (YAML)</td></tr>
  <tr><td>IaC</td><td>Bicep</td></tr>
  <tr><td>Containers</td><td>Docker, Azure Container Registry, Container Apps</td></tr>
  <tr><td>Database</td><td>Azure SQL Database</td></tr>
  <tr><td>Languages</td><td>YAML, Bicep, C#, JavaScript</td></tr>
</table>

---

<h2>📄 Notes</h2>

<p>
This repository was created as part of a school assignment to demonstrate a full DevOps pipeline setup and infrastructure deployment on Azure.
</p>

---

<h3 align="center">💡 “Automate everything — code, build, deploy, and infrastructure.”</h3>
