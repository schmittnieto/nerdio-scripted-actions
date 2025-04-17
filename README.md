# Nerdio Scripted Actions – Community Add‑ons

Hi, I’m **Cristian Schmitt Nieto** 👋  
I spend a lot of my day building and tuning Azure Virtual Desktop environments with **Nerdio Manager**. Whenever I write a Scripted Action that feels useful beyond a single project, I drop it here so others can benefit (and, hopefully, improve on it!).

> **Goal**: complement the great official collection at  
> <https://github.com/Get-Nerdio/NMW/tree/main/scripted-actions>  
> with additional, real‑world scripts that I’ve tested in the field.

## ✨ What you’ll find

A steadily growing set of **practical Scripted Actions** that tackle everyday AVD and Windows management needs.  
Most of them fall into these broad buckets:

* **User‑experience tuning** – tweaks that make sessions feel faster and friendlier.  
* **Security & compliance helpers** – small automations to keep hosts up‑to‑date and compliant.  
* **Utility scripts** – one‑off fixes or conveniences I found handy during deployments.  

I add new material whenever I stumble upon a repeatable task worth scripting.

## 🛠 How to use a script

1. **Copy** the `.ps1` file you’re interested in.  
2. In Nerdio Manager, go to **Scripted Actions → Add from existing → PowerShell** and paste it.  
3. Review the variable defaults (most scripts expose Nerdio dropdowns so you don’t have to edit code).  
4. Attach the Scripted Action to a host pool, image, or scheduled task – done!

## 🤝 Contributing

I’m grateful for feedback, issues, and pull requests.  
If you spot a bug, have an idea, or want to share your own Scripted Action, please open an issue or PR. Just try to:

1. Keep Nerdio’s metadata headers intact (`#description`, `#execution mode`, `#tags`, and optional `#variables`).  
2. Add comments explaining *why* a registry key or setting is changed.  
3. Make scripts idempotent and handle errors where possible.

## 🙏 A note of thanks

A big thank‑you to the Nerdio team and the community around <https://github.com/Get-Nerdio/NMW> – their work is the foundation that makes all of this possible.

## 📄 License

Everything here is released under the **MIT License**. Use it, tweak it, and share it as you like.
