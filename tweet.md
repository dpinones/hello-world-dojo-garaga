1/ 🐺 Introducing "Hunting the Wolf" - A ZK-powered game where a wolf hides among sheep on a 4x4 board!
Players take turns as either the wolf or shepherd, using zero-knowledge proofs to verify moves without revealing secrets. Let me show you how it works! 🧵
2/ 🎮 Game Setup:
16 sheep on a 4x4 board
One player is secretly the wolf
The wolf must kill adjacent sheep
The shepherd must find the wolf
All moves are verified using ZK proofs!
3/ 🐑 The Wolf's Turn:
Selects an adjacent sheep to kill
Generates a ZK proof that verifies:
• It's the real wolf (matches commitment)
• The target sheep is adjacent
• The sheep is alive
All without revealing its identity! 🔒
4/ 👨‍🌾 The Shepherd's Turn:
Observes which sheep was killed
Marks a suspicious sheep
The wolf must then prove if the marked sheep is the wolf
If wrong, the accused sheep dies
If right, the wolf is caught!
5/ 🔄 After each round:
Living sheep are randomly mixed
The wolf maintains its identity
Roles switch between players
The player who kills more sheep as the wolf wins!
6/ 🛠️ Technical Highlights:
Built with Noir for ZK proofs
Smart contract handles game state
Frontend manages user interactions
All moves are verifiable on-chain
Privacy-preserving gameplay!
7/ 🎯 Why ZK?
Wolf's identity stays hidden
Moves are verified without revealing secrets
Trustless gameplay
Perfect for blockchain gaming
Demonstrates practical ZK applications
8/ 🚀 Want to try it out?
Check out our GitHub repo
Join our community
Learn more about ZK gaming
Let's make privacy-preserving games mainstream!