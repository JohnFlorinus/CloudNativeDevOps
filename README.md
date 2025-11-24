<h1 align="center">☁️ Azure CI/CD & Bicep IAC</h1>

<p align="center">
  <strong>DevOps implementation for a multi-container web app deployed to Azure using Docker, Bicep, and Azure Pipelines</strong><br>
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
  <li>Container Apps for frontend and backend are automatically updated, as they track the image in ACR.</li>
</ul>

<p>
This setup enables a reliable and repeatable deployment process. Multi-stage division and unit testing checks were intentionally excluded since the web app was a small demo.
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
  <li>🚀 Container Apps + Environment</li>
  <li>🔑 Azure Key Vault + Automatic RBAC Implementation for Container Access</li>
</ul>

<p>
The use of separate modules ensures separation of concerns and ease of development.
</p>

---

<h2>🌐 Deployment Workflow</h2>

<ol>
  <li>Code is pushed to <code>master</code> branch (production) → triggers the pipeline.</li>
  <li>Azure Pipeline builds and pushes Docker images to ACR.</li>
  <li>Container Apps pull the latest images from ACR → the application goes live.</li>
</ol>
