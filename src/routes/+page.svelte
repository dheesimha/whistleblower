<script>
  import { onMount } from "svelte";
  import { ethers } from "ethers";
  import ABI from "../Whistleblower.json";
  import Icon from "svelte-icons-pack/Icon.svelte";
  import BiUpvote from "svelte-icons-pack/bi/BiUpvote";
  import BiDownvote from "svelte-icons-pack/bi/BiDownvote";
  let window2, provider;
  let CONTRACT_ADDRESS = "0xE27E7fB383F12e2e7D97bF5e518c40bE837c468d";
  onMount(async () => {
    window2 = window;
    console.log(window2.ethereum);

    //   let ANTI_ADDRESS = 0xE27E7fB383F12e2e7D97bF5e518c40bE837c468d;
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

<div class="show-post">
  <button class="btn-createpost">
    <!-- <Link to="/create">Create New Post</Link> -->
    Create Post
  </button>

  <!-- {times.map((time) => ( -->
  <div class="reddit-card">
    <div class="post-details">
      <!-- <small class="subreddit-name"></small> -->
      <small class="username">posted by u/long_username</small>
    </div>

    <div class="reddit-inner-card">
      <div class="card-votes">
        <button>
          <Icon src={BiUpvote} size="23" />
        </button>
        <p>9</p>
        <button>
          <Icon src={BiDownvote} size="23" />
        </button>
      </div>
      <div class="card-text">
        <p class="card-title">
          Genetic doctor recommendation for person with many potential mutations
        </p>
        <p class="card-content">
          Hello, I'm suspected for multiple different genetic disorders, I have
          dozens of different symptoms and many, many potential mutations.
        </p>
      </div>
    </div>
  </div>
  <div class="reddit-card">
    <div class="post-details">
      <!-- <small class="subreddit-name"></small> -->
      <small class="username">posted by u/long_username</small>
    </div>

    <div class="reddit-inner-card">
      <div class="card-votes">
        <button>
          <Icon src={BiUpvote} size="23" />
        </button>
        <p>9</p>
        <button>
          <Icon src={BiDownvote} size="23" />
        </button>
      </div>
      <div class="card-text">
        <p class="card-title">
          Genetic doctor recommendation for person with many potential mutations
        </p>
        <p class="card-content">
          Hello, I'm suspected for multiple different genetic disorders, I have
          dozens of different symptoms and many, many potential mutations.
        </p>
      </div>
    </div>
  </div>
</div>

<!-- <button on:click={connectWallet}>connect wallet</button> -->

<style>
  * {
    padding: 0;
    margin: 0;
  }
  .reddit-card {
    max-width: 600px;
    text-align: left;
    /* border: 1px solid black; */
    margin: 0.5rem auto;
    padding: 1rem 1rem;
    background: #fefeff;
    border-radius: 0.7rem;
  }
  .btn-createpost {
    max-width: 200px;
    width: 100%;
    margin: 0.5rem;
    padding: 0.7rem 0.5rem;
    border: none;
    background: #1485d6;
    color: white;
    border-radius: 0.4rem;
    opacity: 0.8;
  }

  .btn-createpost:hover {
    opacity: 1;
  }

  .btn-createpost a {
    font-size: 1rem;
    color: #fefeff;
  }
  .show-post {
    margin: 1rem 0;
    font-family: "Quicksand", sans-serif;
    text-align: center;
    background: #dbe0e7;
    height: 100%;
    padding: 0.5rem;
  }

  .post-details {
    margin-bottom: 0.3rem;
  }

  .post-details small {
    padding: 0.5rem;
  }

  .post-details .subreddit-name {
    font-size: 0.9rem;
    font-weight: bolder;
    padding-left: 2.5rem;
  }

  .post-details .username {
    color: grey;
    margin-left: 2rem;
  }

  /* css for post and upvotes */

  .reddit-inner-card {
    display: flex;
    justify-content: space-between;
    align-items: flex-start !important;
  }

  .card-text {
    width: 100%;
    margin: auto 0.5rem;
  }

  .card-text .card-title {
    font-weight: bolder;
    font-size: 20px;
    padding-bottom: 0.5rem;
    border-bottom: 0.2px solid #637680;
  }

  .card-votes {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    margin: 0px;
    /* background: #e1e1eb; */
    border-radius: 1.2rem;
  }

  .card-votes button {
    background: transparent;
    border: none;
    cursor: pointer;
    padding: 0.2rem;
  }

  .card-content {
    margin: 0.2rem;
  }
  body {
    background-color: #637680;
  }

  @media only screen and (max-width: 400px) {
    /* body {
    background-color: lightblue;
  } */
  }
</style>
