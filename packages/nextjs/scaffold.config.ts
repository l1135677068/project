import { defineChain } from "viem";
import * as chains from "viem/chains";

export type ScaffoldConfig = {
  targetNetworks: readonly chains.Chain[];
  pollingInterval: number;
  alchemyApiKey: string;
  walletConnectProjectId: string;
  onlyLocalBurnerWallet: boolean;
};

// const linea_tesnet = defineChain({
//   id: 59141,
//   name: "Linea Sepolia",
//   nativeCurrency: {
//     decimals: 18,
//     name: "ETH",
//     symbol: "ETH",
//   },
//   rpcUrls: {
//     default: { http: ["https://linea-sepolia-rpc.publicnode.com"] },
//     public: { http: ["https://linea-sepolia-rpc.publicnode.com"] },
//   },
//   blockExplorers: { default: { url: "https://sepolia.lineascan.build", name: "Linea Sepolia explorer" } },
//   network: "AIA Testnet",
// });
const aia_tesnet = defineChain({
  id: 1320,
  name: "AIA Testnet",
  nativeCurrency: {
    decimals: 18,
    name: "AIA",
    symbol: "AIA",
  },
  rpcUrls: {
    default: { http: ["https://aia-dataseed1-testnet.aiachain.org"] },
    public: { http: ["https://aia-dataseed1-testnet.aiachain.org"] },
  },
  blockExplorers: { default: { url: "https://testnet.aiascan.com", name: "AIA Testnet explorer" } },
  network: "AIA Testnet",
});
const scaffoldConfig = {
  // The networks on which your DApp is live
  targetNetworks: [aia_tesnet],

  // The interval at which your front-end polls the RPC servers for new data
  // it has no effect if you only target the local network (default is 4000)
  pollingInterval: 30000,

  // You can get your Alchemy's default API key at https://dashboard.alchemyapi.io
  // It's recommended to store it in an env variable:
  // .env.local for local testing, and in the Vercel/system env config for live apps.
  alchemyApiKey: process.env.NEXT_PUBLIC_ALCHEMY_API_KEY || "",

  // This is ours WalletConnect's default project ID.
  // You can get your own at https://cloud.walletconnect.com
  // It's recommended to store it in an env variable:
  // .env.local for local testing, and in the Vercel/system env config for live apps.
  walletConnectProjectId: process.env.NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID || "3a8170812b534d0ff9d794f19a901d64",

  // Only show the Burner Wallet when running on hardhat network
  onlyLocalBurnerWallet: true,
} as const satisfies ScaffoldConfig;

export default scaffoldConfig;
