🧠 What is ERC-8004?

ERC‑8004 is a proposed Ethereum standard (EIP) that introduces a trust layer for autonomous agents and interoperable systems. It is designed to fill the gap when “agents” (software, services, machines) need to discover one another, evaluate trustworthiness, and interact across organisational boundaries — without relying solely on centralised authorities. 

🔍 Purpose & Vision

Agents in future Web3/AI ecosystems may perform tasks, interact with each other, form marketplaces, exchange services — but need identity, reputation, and validation primitives to do so in a trustless way. 


ERC-8004 proposes three lightweight on-chain registries to support this: identity registry, reputation registry, validation registry. 

It is built to be chain agnostic (works on Ethereum and EVM-compatible chains) and focuses on minimal on-chain logic (keeping heavy operations off-chain) so that it remains efficient and flexible. 

🧩 Core Components

Identity Registry

Each agent registers an identity (often as an NFT or agent ID) linked to an EVM address or domain. 

Metadata (“Agent Card”) may include capabilities, description, supported schemas, trust models. 

Reputation Registry

Allows off-chain or on-chain feedback, ratings, attestations about past behaviour.

Provides an audit trail so other agents or services can evaluate reliability. 

Validation Registry

Enables stronger guarantees through validation mechanisms: e.g., crypto-economic staking, trusted execution environments (TEEs), zero-knowledge proofs. 

The standard remains abstract regarding which exact validation model is used; implementers can choose (feedback, re-execution, zk/TEE) depending on use-case. 

⚙️ Key Characteristics

Focuses on discovery, trust, interoperability rather than payments or just token standards. 

Minimal on-chain logic means heavy work (scoring, analytics, delegation) can live off-chain, while core registries provide anchored truth. 

Designed to integrate with existing agent-to-agent (A2A) protocols, helping agents from different organisations or ecosystems find each other and transact trusting their registry entries. 


Being still in draft (as of 2025) — which means the specification may evolve, standards may refine. 


🏗 Use Cases

Marketplaces of AI agents (data analysis, report generation, automation) where trust in agent identity + past performance matters. 

Device-to-device or IoT networks where machines need to authenticate and validate one another.

Cross-organisation workflows: e.g., one company’s agent uses services of another’s agent — the identity + reputation layers facilitate safe collaboration.

Validation of results/outcomes (e.g., an agent promises a result, a validator checks it, and the record goes on-chain).