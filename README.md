# Leya Enterprises — Autonomous AI SDLC Demo

A demo of a **fully autonomous, AI-driven Software Development Life Cycle (AI SDLC)**, built around a fictional company: **Leya Enterprises**.

## About this repository

AI agents carry out every phase of software delivery in this repository: planning, design, coding, review, testing, release and operations. People set goals and approve key checkpoints. The agents do the rest.

All of this work needs a business setting. Rather than use a real organization, the repository is built around a made-up one.

## Meet Leya Enterprises

> **Leya Enterprises is a fictional company.** It exists only for demos, documentation and test data, in the same way Microsoft uses *Contoso* and *Northwind Traders*. Any resemblance to real companies, products or people is coincidental.

### Company profile

| | |
|---|---|
| **Name** | Leya Enterprises |
| **Tagline** | *"Everything you need, one cart away."* |
| **Business** | Online e-commerce platform |
| **Headquarters** | Fictional — nowhere and everywhere |
| **Engineering team** | A crew of AI agents, overseen by a small group of human approvers |

Leya runs an online store platform. Its core business capabilities are:

- **Product catalog**: products, categories, search and pricing
- **Cart & checkout**: shopping cart, promotions and payment flow
- **Orders**: order placement, tracking, returns
- **Customer accounts**: registration, profiles, order history
- **Inventory**: stock levels and fulfilment

Together these capabilities give the AI SDLC a realistic but self-contained domain. That domain supplies the user stories, bugs, and new features for the agents to pick up.

### Conventions

To keep the fiction clean and safe:

- **Domain:** use `leya.example` (e.g. `shop.leya.example`, `api.leya.example`). The `.example` TLD is reserved by [RFC 2606](https://www.rfc-editor.org/rfc/rfc2606), so it never resolves to a real site.
- **Email:** use addresses such as `jane.doe@leya.example`.
- **Data:** use only synthetic customers, products, and orders. Never use real personal or payment data.
- **Naming:** use the `Leya` prefix for services, packages and resources (e.g. `LeyaCatalog`, `leya-orders-api`).

## The autonomous SDLC (target model)

This is the delivery model the repository is working toward. It is **not implemented yet**.

| Phase | AI responsibility | Human checkpoint |
|---|---|---|
| **Plan** | Turn business goals into epics, user stories and acceptance criteria | Approve the backlog priorities |
| **Design** | Propose architecture, APIs and data models | Approve major design decisions |
| **Build** | Implement features and fixes on branches | — |
| **Review** | Review pull requests for correctness, security and style | — |
| **Test** | Generate and run unit, integration and end-to-end tests | — |
| **Release** | Version, write changelogs and deploy | Approve production releases |
| **Operate** | Monitor, triage incidents and open follow-up work | Handle escalations |

## Status

🚧 **Early stage.** At the moment the repository contains only this README.

Planned next:

- The Leya e-commerce application
- AI agent definitions for each SDLC phase
- CI/CD pipelines that connect the agents together

---

*Leya Enterprises, its products and its people are fictional. Created for demonstration purposes only.*
