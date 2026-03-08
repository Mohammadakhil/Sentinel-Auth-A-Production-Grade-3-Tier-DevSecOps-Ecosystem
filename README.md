<<<<<<< HEAD
# Sentinel-Auth-A-Production-Grade-3-Tier-DevSecOps-Ecosystem
=======
# 🛡️ Sentinel-Auth

A secure user registration microservice built with **FastAPI** + a **React** DevOps dashboard.

---

## Architecture

```
Secure-Auth/
├── app/                    # FastAPI Backend
│   ├── main.py             # App entry + CORS
│   ├── api/
│   │   ├── routes.py       # GET /health · POST /register
│   │   └── schemas.py      # Pydantic v2 models
│   ├── core/
│   │   ├── config.py       # Env-based settings (pydantic-settings)
│   │   └── security.py     # bcrypt hashing (passlib)
│   └── db/
│       ├── models.py       # SQLAlchemy 2.0 User model
│       └── session.py      # Engine + session factory
├── tests/                  # Pytest suite (7 tests, no live DB needed)
│   ├── conftest.py         # In-memory SQLite override
│   ├── test_health.py
│   └── test_register.py
├── frontend/               # React + Vite + Tailwind CSS
│   └── src/
│       ├── App.jsx         # DevOps Dashboard UI
│       ├── index.css       # Dark theme + animations
│       └── main.jsx
└── requirements.txt
```

---

## Quick Start

### Prerequisites

| Tool       | Version  |
|------------|----------|
| Python     | 3.10+    |
| Node.js    | 20.19+   |
| PostgreSQL | 13+ *(only for production — tests use SQLite)* |

### 1. Backend

```bash
cd Secure-Auth

# Install dependencies
pip install -r requirements.txt

# Run the server (Explicitly bind to 127.0.0.1 for local dev harmony)
uvicorn app.main:app --reload --host 127.0.0.1 --port 8000
# → http://127.0.0.1:8000
# → Swagger UI: http://127.0.0.1:8000/docs
```

### 2. Frontend

```bash
cd Secure-Auth/frontend

# Install dependencies
npm install

# Start dev server
npm run dev
# → http://127.0.0.1:5173
```

### 3. Run Tests

```bash
cd Secure-Auth
pytest tests/ -v
```

All 7 tests run against an **in-memory SQLite** database — no PostgreSQL required.

---

## API Reference

### `GET /health`

Returns service status and current UTC timestamp.

### `GET /ping`

Simple diagnostic endpoint for connectivity testing. Returns text `"pong"`.

### `OPTIONS /register`

Handled explicitly for CORS preflight robustness.

```json
{
  "status": "ok",
  "timestamp": "2026-03-08T00:30:00+00:00"
}
```

### `POST /register`

Register a new user.

**Request Body:**
```json
{
  "username": "sentinel_admin",
  "password": "Str0ngP@ss!"
}
```

**Success (201):**
```json
{
  "id": 1,
  "username": "sentinel_admin",
  "created_at": "2026-03-08T00:30:00+00:00"
}
```

**Duplicate (400):**
```json
{ "detail": "Username already registered" }
```

---

## Environment Variables

| Variable      | Default         | Description              |
|---------------|-----------------|--------------------------|
| `DB_USER`     | `postgres`      | PostgreSQL username      |
| `DB_PASSWORD` | `postgres`      | PostgreSQL password      |
| `DB_HOST`     | `localhost`      | Database host            |
| `DB_PORT`     | `5432`          | Database port            |
| `DB_NAME`     | `sentinel_auth` | Database name            |

> You can also place these in a `.env` file in the project root.

---

## Frontend Features

| Feature             | Description                                                    |
|---------------------|----------------------------------------------------------------|
| **Register Tab**    | Username + password form → `POST /register` with toast alerts  |
| **Status Tab**      | Live health polling (30s), green pulse / red offline indicator  |
| **Manual Refresh**  | Re-check backend health on demand                              |
| **Toast Alerts**    | 🛡️ Account Created · ❌ Username Taken · 📡 Backend Offline    |
| **Responsive**      | Centered card layout that works on any screen size             |

---

## Tech Stack

| Layer      | Technology                              |
|------------|-----------------------------------------|
| Backend    | FastAPI · SQLAlchemy 2.0 · Pydantic v2  |
| Auth       | passlib + bcrypt                        |
| Database   | PostgreSQL (prod) · SQLite (tests)      |
| Frontend   | React · Vite · Tailwind CSS · Axios     |
| Testing    | pytest · httpx · FastAPI TestClient      |

---

>>>>>>> deaba10 (initial commit)
