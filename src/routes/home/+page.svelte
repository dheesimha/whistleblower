<script>
     import Icon from 'svelte-icons-pack/Icon.svelte';
     import BsArrowDownRight from "svelte-icons-pack/bs/BsArrowDownRight";
</script>

<div class="outershell">
<div class="homepage-wrapper">
    <div class="navbar">
        <p class="title">Ghost Speak</p>
        <div class="nav-center">
            <p class="nav-title">products</p>
            <p class="nav-title">about us</p>
            <p class="nav-title">blog</p>
        </div>
        <button class="contact-us-button">contact us</button>
    </div>
    <div class="hero-wrapper">
        <div class="hero">
            <div class="hero-image-wrapper">
                <img src="https://eddiecolla.files.wordpress.com/2011/02/img_3995.jpg" alt="" class="hero-image" />
            </div>
            <div class="hero-content-wrapper">
                <p class="mini-title">[top secret]</p>
                <p class="main-title">Unleash the <span class='framed'>unheard:</span> Whistleblow anonymously, <span class='framed'>fearlessly</span></p>
                <button class="blow">
                    <p class="blow-text">Blow your whistle</p>
                    <Icon src={BsArrowDownRight}   /> 
                </button>
            </div>
        </div>
    </div>
</div>
</div>

<style>
   *{

padding: 0;
margin: 0;
}
.outershell{
    background-color: #000000;
    height: 100vh;
}
.mini-title{
    font-family: 'Courier New', Courier, monospace;
    font-size: 17px;
    font-weight: 800;
}

.main-title{
    font-family: 'Nunito Sans';
    font-size: 48px;
    font-weight: 700;
    width: 90%;
    text-transform: uppercase;
}

.blow{
    display: flex;
    padding: 17px;
    font-size: 18px;
    justify-content: space-between;
    outline: none;
    border: none;
    align-items: center;
    /* font-family: 'Nunito Sans'; */
    font-weight: 500;
    border-radius: 6px;
    color: white;
    background-color: black;
}

.blow-text{
    padding-right: 10px;
}

.homepage-wrapper{
    display: flex;
    flex-direction: column;
    padding: 30px;
}
.navbar{
    border-radius: 20px 20px 7px 7px;
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
.hero-wrapper{
    background-color: white;
    padding: 18px 18px;
    display: flex;
    flex-direction: column;
    border-radius:  7px 7px 20px 20px;

}
.hero{
    display: flex;
    margin: 30px;

}
.hero-image-wrapper{
    flex: 3;
    display: flex;
    justify-content: center;
}
.hero-image{
    height: 500px;
    border-radius: 10px;
}
.hero-content-wrapper{
    flex: 4;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: baseline;
}
.framed{
    padding:0px 10px;
    border: 1px solid #131312;
    border-radius: 10px;
    color: white;
    background-color: #f84444;
    /* align-self: flex-start; */
    text-align: left;
}
</style>