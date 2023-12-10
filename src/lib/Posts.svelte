
<script>
     import Icon from 'svelte-icons-pack/Icon.svelte';
  import BiUpvote from "svelte-icons-pack/bi/BiUpvote";
  import BiDownvote from "svelte-icons-pack/bi/BiDownvote";
  export let p_id, file,title, description, u_id;
</script>
<div class="reddit-card">
    <div class="post-details">
      <!-- <small class="subreddit-name"></small> -->
      <small class="username">posted by {u_id}</small>
    </div>

    <div class="reddit-inner-card">
      <div class="card-votes">
        <button >
          <Icon src={BiUpvote} size='23' />
        </button>
        <p>9</p>
        <button >
          <Icon src={BiDownvote} size='23' />
        </button>
      </div>
      <div class="card-text">
        <p class="card-title">{title}</p>
        <p class="card-content">{description}</p>
      </div>
    </div>
  </div>


<style>
  *{
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
  /* border-bottom: 0.2px solid #637680; */
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
</style>