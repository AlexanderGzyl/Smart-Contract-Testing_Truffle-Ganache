const VendingMachine = artifacts.require("VendingMachine");
// 
contract("VendingMachine", (accounts)=> {
    // first deploy contract
    beforeEach(async ()=>{
        instance = await VendingMachine.deployed()
    });
    it('ensure that the starting balance of the vending machine is 100 donuts', async ()=>{
        let balance = await instance.getVendingMachineBalance()
        assert.equal(balance,100,'The initial balance should be 100 donuts.')
    });

    it("ensures the balance of the vending machine can be updated", async()=>{
        await instance.restock(100)
        let balance = await instance.getVendingMachineBalance()
        assert.equal(balance,200,'The initial balance should be 200 donuts.')
    });

    it('allows donuts to be purchased', async()=>{
        // input includes truffle abstraction that allows us to mimic purchases
        await instance.purchase(1,{from: accounts[0], value:web3.utils.toWei("3","ether")});
        let balance = await instance.getVendingMachineBalance()
        assert.equal(balance,99,'The  balance should be 99 donuts after sale.')

    });
});