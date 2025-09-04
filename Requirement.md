Mini CI with Docker-in-Docker — Requirements

🎯 Goal

Run a mini CI pipeline using Docker-in-Docker (DinD) to:
	•	Build a sample app image
	•	Run the app inside DinD
	•	Test it with curl
	•	Print results and clean up

⸻

📦 Scope
	•	DinD service (docker:dind) with --privileged
	•	CI runner (docker:cli) talking to DinD via DOCKER_HOST
	•	Sample Node.js app with HTTP endpoint
	•	CI script: build → run → test → cleanup

⸻

✅ Functional Requirements
	1.	DinD service must start and be healthy.
	2.	CI runner must build myapp:ci image inside DinD.
	3.	App must run in DinD on a private network.
	4.	Test must curl the app and check response.
	5.	Show running containers (docker ps) and then clean up.

⸻

🔧 Non-Functional
	•	Easy to run: docker compose up --build.
	•	Works on Docker Desktop/Linux/WSL2.
	•	Minimal dependencies (just Docker + Compose).

⸻

📂 Deliverables
	•	docker-compose.yml
	•	ci/run.sh (pipeline script)
	•	app/ (Node.js app with Dockerfile)
	•	README.md (setup + usage)

⸻

✅ Success Criteria
	•	Pipeline runs end-to-end with “✅ Test passed” message.
	•	myapp:ci image exists inside DinD, not on the host.
	•	Docs are clear for a first-time user to follow.