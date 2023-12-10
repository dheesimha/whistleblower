<script>
  import { onMount } from "svelte";
  import { ethers } from "ethers";
  import ABI from "../Whistleblower.json";
  import Modal from "$lib/Modal.svelte";
  import { signer, signerAddress } from "../stores.js";
  // import { Button, Modal } from 'antd';
  import Posts from "$lib/Posts.svelte";
  let showModal = false;
  let window2, provider;
  let CONTRACT_ADDRESS = "0xCd31A1a5B66e8B4E178a9AcD3A858ed009ac781f";
  onMount(async () => {
    window2 = window;
    console.log(window2.ethereum);
    console.log($signer);
    if ($signer == null || $signer == undefined) {
      await connectWallet();
      console.log("calling connectWallet");
      console.log("Signer");
    }

    //   let ANTI_ADDRESS = 0xd9145cce52d386f254917e481eb44e9943f39138;
    //   let ANTI_ABI = ABI;
    //   const provider = new ethers.providers.Web3Provider(window2.ethereum);
    //   const signer = provider.getSigner();
    //   const anti = new ethers.Contract(ANTI_ADDRESS, ANTI_ABI, signer);
  });
  let allPosts;
  // let post
  async function connectWallet() {
    if (window2.ethereum) {
      try {
        // Create an ethers provider using MetaMask's injected ethereum object
        console.log("inside this func");
        provider = new ethers.providers.Web3Provider(window2.ethereum);

        // Request permission to access the user's accounts
        await window2.ethereum.request({ method: "eth_requestAccounts" });

        // Get the signer
        // @ts-ignore
        await signer.set(provider.getSigner());
        if ($signer !== null) {
          let address = await $signer.getAddress();
          console.log(address);
          await $signerAddress.set(address);
        }

        // Proceed with further interactions using 'provider' and 'signer'

        // For example, you can interact with your contract using the signer:
        const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, $signer);
        // Call contract functions, etc.
        allPosts = await contract.getAllPosts();
        console.log(allPosts);
        // post = allPosts[0]
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

  async function createPost() {
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, $signer);
    await contract.createPost(
      "this is title",
      "this is the long description",
      "https://gateway.lighthouse.storage/ipfs/QmXPT5Kw285W96jdCes5SufvrqQvYN8dtMM258kW9Eqy3u",
      "11"
    );
  }
  async function getPosts() {
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, $signer);
    let post = await contract.getAllPosts();
    console.log(post);
  }
</script>

<div class="show-post">
  <button class="btn-createpost" on:click={createPost}>
    <!-- <Link to="/create">Create New Post</Link> -->
    Create Post
  </button>
  <button class="btn-createpost" on:click={getPosts}>
    <!-- <Link to="/create">Create New Post</Link> -->
    get Post
  </button>
  <!-- {times.map((time) => ( -->
  <!-- {allPosts==null? null : allPosts.map((post)=>{  })} -->
  <!-- {allPosts?.map((post) => {
return (<Posts p_id={post?.post_id} title={post?.post_title} file={post?.file_address} description={post?.post_description} u_id={post?.uploader_id} />)
    })} -->

  <!-- {allPosts.map((post) => (
      <Posts p_id={post?.post_id} title={post?.post_title} file={post?.file_address} description={post?.post_description} u_id={post?.uploader_id} />
    ))} -->

  <!-- Ensure allPosts is an array or initialize it as an empty array -->
  {#if allPosts && allPosts.length > 0}
    {#each allPosts as postItems}
      <Posts
        p_id={postItems.post_id}
        title={postItems.post_title}
        file={postItems.file_address}
        description={postItems.post_description}
        u_id={postItems.uploader_id}
      />
    {/each}
  {:else}
    <!-- Handle case when allPosts is null or empty -->
    <p>No posts available</p>
  {/if}
  <!-- <div on:click={()=> showModal=true} class='post-wrapper' >
      <Posts  />
    </div>
 
  <Posts /> -->

  <button on:click={() => (showModal = true)}> show modal </button>

  <Modal bind:showModal>
    <h2 slot="header">
      modal
      <small><em>adjective</em> mod·al \ˈmō-dəl\</small>
    </h2>

    <ol class="definition-list">
      <li>of or relating to modality in logic</li>
      <li>
        containing provisions as to the mode of procedure or the manner of
        taking effect —used of a contract or legacy
      </li>
      <li>of or relating to a musical mode</li>
      <li>of or relating to structure as opposed to substance</li>
      <li>
        of, relating to, or constituting a grammatical form or category
        characteristically indicating predication
      </li>
      <li>of or relating to a statistical mode</li>
    </ol>

    <a href="https://www.merriam-webster.com/dictionary/modal"
      >merriam-webster.com</a
    >
  </Modal>
</div>

<!-- <button on:click={connectWallet}>connect wallet</button> -->

<style>
  * {
    padding: 0;
    margin: 0;
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

  /* css for post and upvotes */
  body {
    background-color: #637680;
  }
  .post-wrapper {
    /* max-width: 600px; */
  }
  @media only screen and (max-width: 400px) {
    /* body {
    background-color: lightblue;
  } */
  }
</style>
