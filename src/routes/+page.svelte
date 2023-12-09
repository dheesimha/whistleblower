<script>
  import { onMount } from "svelte";
  import { ethers } from "ethers";
  import ABI from "../Whistleblower.json";
  let window2, provider;
  let CONTRACT_ADDRESS = "0xd9145cce52d386f254917e481eb44e9943f39138";
  onMount(async () => {
    window2 = window;
    console.log(window2.ethereum);

    //   let ANTI_ADDRESS = 0xd9145cce52d386f254917e481eb44e9943f39138;
    //   let ANTI_ABI = ABI;
    //   const provider = new ethers.providers.Web3Provider(window2.ethereum);
    //   const signer = provider.getSigner();
    //   const anti = new ethers.Contract(ANTI_ADDRESS, ANTI_ABI, signer);
  });

  async function connectWallet() {
    if (window2.ethereum) {
      try {
        // Create an ethers provider using MetaMask's injected ethereum object
        console.log("inside this func");
        provider = new ethers.providers.Web3Provider(window2.ethereum);

        // Request permission to access the user's accounts
        await window2.ethereum.request({ method: "eth_requestAccounts" });

        // Get the signer
        const signer = provider.getSigner();

        // Proceed with further interactions using 'provider' and 'signer'

        // For example, you can interact with your contract using the signer:
        const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, signer);
        // Call contract functions, etc.

        console.log(contract);
      } catch (error) {
        // Handle errors during account access request or other interactions
        console.error("Error:", error);
      }
    } else {
      //   alert(
      //     "Please install MetaMask or a similar Ethereum-enabled browser extension"
      //   );
      console.log("outside this func");
    }
  }
</script>

<h1>Welcome to SvelteKit</h1>
<p>
  Visit <a href="https://kit.svelte.dev">kit.svelte.dev</a> to read the documentation
</p>

<button on:click={connectWallet}>connect wallet</button>

<style>
</style>
