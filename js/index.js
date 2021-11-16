const address=0x000;
const abi=/* Your abi */

$(function()
{
    var NFT_Game;
    var lastmeal=0;
    var endurance=0;
    $(document).ready(function()
    {

		NFT_Game.getTokensOfUser.call('0x1D6d6eEeFA5ecC9DFbEA5399De89A63b65134D5E',function(err,result)
		{
			for(var i=0; i<result.length;i++)
			{
				$("#pets").append($.parseHTML('<option value=${result[i]}>${result[i]}</option>'))
			}
		});
		$('#go').click(function()
		{
			var id=document.getElementById('pets').ariaValueMax;
			document.getElementById('petId').innerHTML=id;
			NFT_Game.Endurance.call(id,function(err,result)
        {
            document.getElementById('endurance').innerHTML=result;
            endurance = result;
        });

        NFT_Game.Damage.call(id,function(err,result)
        {
            document.getElementById('damage').innerHTML=result;
        });

        NFT_Game.Magic.call(id,function(err,result)
        {
            document.getElementById('magic').innerHTML=result;
        });

        NFT_Game.LastMeal.call(id,function(err,result)
        {
            lastmeal = result;
            deathtime = new Date((parseInt(lastmeal)+parseInt(endurance))*1000);
            document.getElementById('starvation').innerHTML=deathtime;
        });

        $("#feed").click(function()
        {
         NFT_Game.Feed.sendTransaction(id,function(err, hash)
         {

         });

        });
		})
        
    });
    

    if(typeof(web3)==='undefined'){
        console.log("Unable to find web3."+"Please run Metamask");
    
    }else{
        console.log("Found injected web3");
        web3=new Web3(web3.currentProvider);
        ethereum.request({ method: 'eth_requestAccounts' });
        if(web3.version.getNetwork!==4){
            console.log("Wrong network detected");
        }
        else{
            console.log("Connected to Rinkeby");
            NFT_Game = web3.eth.contract(abi).at(address);        }
    }
});
