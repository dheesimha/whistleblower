<script>
  import lighthouse from "@lighthouse-web3/sdk";
  import { onMount } from "svelte";
  import { ethers } from "ethers";
  import { signer } from "../../stores";
  import ABI from "../../Whistleblower.json";
  let CONTRACT_ADDRESS = "0xCd31A1a5B66e8B4E178a9AcD3A858ed009ac781f";

  let window2, provider;

  onMount(async () => {
    window2 = window;
    console.log(window2.ethereum);
    if ($signer !== null || $signer !== undefined) {
      await connectWallet();
    }
  });

  let allPosts;
  let postItems;
  let modalNo;
  async function connectWallet() {
    if (window2.ethereum) {
      try {
        // Create an ethers provider using MetaMask's injected ethereum object
        console.log("inside this func");
        provider = new ethers.providers.Web3Provider(window2.ethereum);

        // Request permission to access the user's accounts
        await window2.ethereum.request({ method: "eth_requestAccounts" });

        // Get the signer
        await signer.set(provider.getSigner());

        // localStorage.setItem("signer", JSON.stringify($signer));

        if ($signer !== null || $signer !== undefined) {
          console.log("Address");
          let signerWalletAddress = await $signer.getAddress();
          console.log(signerWalletAddress);
          localStorage.setItem("signerAddress", signerWalletAddress);

          console.log("The signer is");
          console.log($signer);
        }

        // Proceed with further interactions using 'provider' and 'signer'

        // For example, you can interact with your contract using the signer:
        const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, $signer);
        // Call contract functions, etc.
        allPosts = await contract.getAllPosts();
        console.log(allPosts);
        postItems = allPosts[1];
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

  const progressCallback = (progressData) => {
    let percentageDone =
      100 - (progressData?.total / progressData?.uploaded)?.toFixed(2);
    console.log(percentageDone);
  };
  let myId;
  console.log($signer);
  onMount(() => {
    myId = localStorage.getItem("signerAddress");
  });

  let newLink;

  const uploadFile = async (file) => {
    const output = await lighthouse.upload(
      file,
      "d8ee101c.800c068867e54a9c881008303220d9f0",
      false,
      null,
      progressCallback
    );
    console.log("File Status:", output);

    console.log(
      "Visit at https://gateway.lighthouse.storage/ipfs/" + output.data.Hash
    );
    newLink = "https://gateway.lighthouse.storage/ipfs/" + output.data.Hash;
    createPost();
  };

  async function createPost() {
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, $signer);
    await contract.createPost(
      "title of document",
      "description of the document",
      newLink,
      myId
    );
  }
</script>

<form action="" method="get" class="speaker-form">
  <div class="form-row">
    <h1>Create a post</h1>
  </div>
  <div class="form-row">
    <label for="title">Title of the document</label>
    <input id="title" name="title" type="text" />
  </div>

  <div class="form-row">
    <label for="description">Description of the case</label>
    <textarea id="description" name="description" rows="4" cols="50" />
  </div>

  <input type="file" on:change={(e) => uploadFile(e.target.files)} />

  <div class="form-row">
    <button>Submit</button>
  </div>
</form>

<style>
  body {
    color: #5d6063;
    background-color: #eaedf0;
    font-family: "Helvetica", "Arial", sans-serif;
    font-size: 16px;
    line-height: 1.3;

    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .speaker-form-header {
    text-align: center;
    background-color: #f6f7f8;
    border: 1px solid #d6d9dc;
    border-radius: 3px;

    width: 80%;
    margin: 40px 0;
    padding: 50px;
  }

  .speaker-form-header h1 {
    font-size: 30px;
    margin-bottom: 20px;
  }

  .speaker-form {
    background-color: #f6f7f8;
    border: 1px solid #d6d9dc;
    border-radius: 3px;

    width: 80%;
    padding: 50px;
    margin: 0 0 40px 0;
  }

  .form-row {
    margin-bottom: 40px;
    display: flex;
    justify-content: flex-start;
    flex-direction: column;
    flex-wrap: wrap;
  }

  .form-row input[type="text"],
  .form-row input[type="email"] {
    background-color: #ffffff;
    border: 1px solid #d6d9dc;
    border-radius: 3px;
    width: 100%;
    padding: 7px;
    font-size: 14px;
  }

  .form-row label {
    margin-bottom: 15px;
  }

  .form-row input[type="text"]:invalid,
  .form-row input[type="email"]:invalid {
    border: 1px solid #d55c5f;
    color: #d55c5f;
    box-shadow: none; /* Remove default red glow in Firefox */
  }

  .legacy-form-row {
    border: none;
    margin-bottom: 40px;
  }

  .legacy-form-row legend {
    margin-bottom: 15px;
  }

  .legacy-form-row .radio-label {
    display: block;
    font-size: 14px;
    padding: 0 20px 0 10px;
  }

  .legacy-form-row input[type="radio"] {
    margin-top: 2px;
  }

  .legacy-form-row .radio-label,
  .legacy-form-row input[type="radio"] {
    float: left;
  }

  .form-row select {
    width: 100%;
    padding: 5px;
    font-size: 14px; /* This won't work in Chrome or Safari */
    -webkit-appearance: none; /* This will make it work */
  }

  .form-row textarea {
    font-family: "Helvetica", "Arial", sans-serif;
    font-size: 14px;

    border: 1px solid #d6d9dc;
    border-radius: 3px;

    min-height: 200px;
    margin-bottom: 10px;
    padding: 7px;
    resize: none;
  }

  .form-row .instructions {
    color: #999999;
    font-size: 14px;
    margin-bottom: 30px;
  }

  .form-row .checkbox-label {
    margin-bottom: 0;
  }

  .form-row button {
    font-size: 16px;
    font-weight: bold;

    color: #ffffff;
    background-color: #5995da;

    border: none;
    border-radius: 3px;

    padding: 10px 40px;
    cursor: pointer;
  }

  .form-row button:hover {
    background-color: #76aeed;
  }

  .form-row button:active {
    /* background-color: #407fc7; */
    background-color: pink;
  }

  @media only screen and (min-width: 700px) {
    .speaker-form-header,
    .speaker-form {
      width: 600px;
    }
    .form-row {
      flex-direction: row;
      align-items: flex-start; /* To avoid stretching */
      margin-bottom: 20px;
    }
    .form-row input[type="text"],
  .form-row input[type='email'],    /* Add */
  .form-row select,                 /* These */
  .form-row textarea {
      /* Selectors */
      width: 250px;
      height: initial;
    }
    .form-row label {
      text-align: right;
      width: 120px;
      margin-top: 7px;
      padding-right: 20px;
    }
    .legacy-form-row {
      margin-bottom: 10px;
    }
    .legacy-form-row legend {
      width: 120px;
      text-align: right;
      padding-right: 20px;
    }
    .legacy-form-row legend {
      float: left;
    }
    .form-row .instructions {
      margin-left: 120px;
    }
    .form-row .checkbox-label {
      margin-left: 120px;
      width: auto;
    }
    .form-row button {
      margin-left: 120px;
    }
  }
</style>
