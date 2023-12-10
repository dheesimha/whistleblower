<script>
  import lighthouse from "@lighthouse-web3/sdk";
  import { onMount } from "svelte";
  import { ethers } from "ethers";
  import {signer} from '../../stores'
  import ABI from "../../Whistleblower.json";
  let CONTRACT_ADDRESS = "0xCd31A1a5B66e8B4E178a9AcD3A858ed009ac781f";
  const progressCallback = (progressData) => {
    let percentageDone =
      100 - (progressData?.total / progressData?.uploaded)?.toFixed(2)
    console.log(percentageDone
    )
  }
  let myId
  console.log($signer);
onMount(()=>{
  myId = localStorage.getItem('signerAddress')
})

let newLink


const uploadFile = async(file) =>{

const output = await lighthouse.upload(file, "d8ee101c.800c068867e54a9c881008303220d9f0", false, null, progressCallback)
console.log('File Status:', output)

  console.log('Visit at https://gateway.lighthouse.storage/ipfs/' + output.data.Hash)
  newLink='https://gateway.lighthouse.storage/ipfs/'+output.data.Hash
  createPost()
}
async function createPost() {
    const contract = new ethers.Contract(CONTRACT_ADDRESS, ABI, JSON.parse(localStorage.getItem('signer')));
    await contract.createPost(
      "title of document",
      "description of the document",
      newLink,
      myId
    );
  }
</script>

<input type="file" on:change={(e) => uploadFile(e.target.files)} />
