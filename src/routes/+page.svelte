<script>
  import { onMount } from "svelte";
  import { ethers } from "ethers";
  import ABI from "../Whistleblower.json";
  let CONTRACT_ADDRESS = "0xCd31A1a5B66e8B4E178a9AcD3A858ed009ac781f";
  import Modal from "$lib/Modal.svelte";
  import { signer } from "../stores.js";
  // import { Button, Modal } from 'antd';
  import Posts from "$lib/Posts.svelte";
  let showModal = false;
  let window2, provider;

  onMount(async () => {
    window2 = window;
    console.log(window2.ethereum);
    if ($signer !== null || $signer !== undefined) {
      await connectWallet();
    }

    //   let ANTI_ADDRESS = 0xd9145cce52d386f254917e481eb44e9943f39138;
    //   let ANTI_ABI = ABI;
    //   const provider = new ethers.providers.Web3Provider(window2.ethereum);
    //   const signer = provider.getSigner();
    //   const anti = new ethers.Contract(ANTI_ADDRESS, ANTI_ABI, signer);
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

  async function createPost() {
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, $signer);
    await contract.createPost(
      "this is title222",
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
  let comments;
  async function getComments(post_id) {
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, $signer);
    comments = await contract.getCommentsByPost(post_id);
    console.log(comments[0]);
  }
</script>

<div class="show-post">
  <div class="navbar">
    <p class="title">Ghost Speak</p>
    <div class="nav-center">
        <p class="nav-title"> <a href="/" style="text-decoration: none;">Leaks</a></p>
        <p class="nav-title"> <a href="/create" style="text-decoration: none;">Publish</a></p>
        <p class="nav-title">blog</p>
    </div>
    <button class="contact-us-button">contact us</button>
</div>
  <!-- {times.map((time) => ( -->
  <!-- {allPosts==null? null : allPosts.map((post)=>{  })} -->
  <!-- {allPosts?.map((post) => {
return (<Posts p_id={post?.post_id} title={post?.post_title} file={post?.file_address} description={post?.post_description} u_id={post?.uploader_id} />)
    })} -->

  <!-- {allPosts.map((post) => (
      <Posts p_id={post?.post_id} title={post?.post_title} file={post?.file_address} description={post?.post_description} u_id={post?.uploader_id} />
    ))} -->

  <!-- {allPosts?.map((postItems)=>( -->
  <!-- 111<div on:click={()=> showModal=true} class='post-wrapper' >
      <Posts p_id={postItems?.post_id} title={postItems?.post_title} file={postItems?.file_address} description={postItems?.post_description} u_id={postItems?.uploader_id}/>
      </div>  111 -->
  <!-- ))} -->
  <!-- <div on:click={()=> showModal=true} class='post-wrapper' >
      <Posts  />
    </div>
 
  <Posts /> -->
  {#if allPosts && allPosts.length > 0}
    {#each allPosts as postItems}
      <div
        on:click={() => {
          showModal = true;
          modalNo = postItems;
          getComments(postItems.post_id);
        }}
        class="post-wrapper"
      >
        <Posts
          p_id={postItems.post_id}
          title={postItems.post_title}
          file={postItems.file_address}
          description={postItems.post_description}
          u_id={postItems.uploader_id}
        />
      </div>
    {/each}
  {:else}
    <!-- Handle case when allPosts is null or empty -->
    <p>No posts available</p>
  {/if}

  <Modal bind:showModal>
    <Posts
      p_id={modalNo?.post_id}
      title={modalNo?.post_title}
      file={modalNo?.file_address}
      description={modalNo?.post_description}
      u_id={modalNo?.uploader_id}
    />
    <hr />
    <p>Comments</p>
    <div class="comment-section">
      <!-- {#if comments && comments.length > 0}
        {#each i as comments[0]} -->
      <small class="username">0x45D98252382aC4A952FaA8b519639D5D3046C64E</small>
      <p class="card-content">this is a test comment</p>
      <input type="text" placeholder="enter comment" />
      <!-- {comments?.map((comment)=>{
          <small class="username">posted by {u_id}</small>
        })} -->
    </div>
  </Modal>
</div>

<!-- <button on:click={connectWallet}>connect wallet</button> -->

<style>
  * {
    padding: 0;
    margin: 0;
  }

.navbar{
    border-radius: 12px 12px 12px 12px;
    background-color: white;
    /* width: 100%; */
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 18px 18px;
    margin-bottom: 2px;
}
.title{
    font-size: 23px;
    font-weight: 800;
    text-transform: uppercase;
    font-family: 'Courier New', Courier, monospace;
    cursor: pointer;
}

.nav-center{
    display: flex;
}

.nav-title{
    margin: 0 40px;
    font-size: 14px;
    text-transform: uppercase;
    cursor: pointer;
    font-family: Arial, Helvetica, sans-serif;
}

.contact-us-button{
    padding: 13px;
    font-size: 14px;
    text-transform: uppercase;
    color: white;
    background-color: black;
    border: none;
    cursor: pointer;
    border-radius: 6px;
    outline: none;
}
  .comment-section {
    width: 600px;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    font-size: 17px;
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
  .username {
    color: grey;
    text-overflow: ellipsis;
    font-size: 14px;
    /* margin-left: 2rem; */
  }
  @media only screen and (max-width: 400px) {
    /* body {
    background-color: lightblue;
  } */
  }
</style>
