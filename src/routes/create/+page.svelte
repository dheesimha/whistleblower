<script>
    import lighthouse from '@lighthouse-web3/sdk'
    const progressCallback = (progressData) => {
    let percentageDone =
      100 - (progressData?.total / progressData?.uploaded)?.toFixed(2)
    console.log(percentageDone)
  }

  const uploadFile = async(file) =>{

    const output = await lighthouse.upload(file, "d8ee101c.800c068867e54a9c881008303220d9f0", false, null, progressCallback)
    console.log('File Status:', output)

      console.log('Visit at https://gateway.lighthouse.storage/ipfs/' + output.data.Hash)
    }

    
</script>

<input type="file" on:change={e=>uploadFile(e.target.files)}  />