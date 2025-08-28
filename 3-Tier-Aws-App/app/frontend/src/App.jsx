import React, { useEffect, useState } from "react";
import { API_BASE_URL } from "./config.js";
import "./App.css";

function App() {
  const [msg, setMsg] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`${API_BASE_URL}/message`)
      .then((res) => res.json())
      .then((data) => {
        setMsg(data.message);
        setLoading(false);
      })
      .catch(() => {
        setMsg("⚠️ Failed to fetch message");
        setLoading(false);
      });
  }, []);

  return (
    <div className="container">
      {/* HEADER */}
      <header>
        <div className="logo">
          <i className="fas fa-rocket"></i>
        </div>
        <h1>React Frontend Application</h1>
        <p className="subtitle">
          Connected to a powerful backend API with real-time data fetching
        </p>
      </header>

      {/* STATUS CARD */}
      <div className="card">
        <div className="status-container">
          <div className="status-header">
            <i className="fas fa-comment status-icon"></i>
            <h2 className="status-title">Backend Communication</h2>
          </div>

          <div className="message-box">
            <div className="message-label">Message from backend API:</div>
            <div className="message-content">
              <i className="fas fa-comment-dots"></i>
              {loading ? (
                <span>⏳ Waiting for backend...</span>
              ) : (
                <span>{msg}</span>
              )}
            </div>
          </div>

          {loading && (
            <div className="loading">
              <div className="spinner"></div>
              <div className="loading-text">Fetching data...</div>
            </div>
          )}
        </div>
      </div>

      {/* STATS */}
      <div className="stats">
        <div className="stat-box">
          <i className="fas fa-bolt stat-icon"></i>
          <div className="stat-value">24 ms</div>
          <div className="stat-label">Response Time</div>
        </div>
        <div className="stat-box">
          <i className="fas fa-server stat-icon"></i>
          <div className="stat-value">99.9%</div>
          <div className="stat-label">Uptime</div>
        </div>
        <div className="stat-box">
          <i className="fas fa-database stat-icon"></i>
          <div className="stat-value">256</div>
          <div className="stat-label">Requests Today</div>
        </div>
      </div>

      {/* FOOTER */}
      <footer>
        <p>Powered by React & Docker | API Endpoint</p>
        <div className="api-url">{`${API_BASE_URL}/message`}</div>
      </footer>
    </div>
  );
}

export default App;
