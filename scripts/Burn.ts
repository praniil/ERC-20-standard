import hre from "hardhat"

const address = "0xd425373f7a05E512b851CfC87bAA5a16a0e063cc"
const amount = 10;

async function main() {
    const [owner, otherAccount] = await hre.ethers.getSigners();
    const erc20 = await hre.ethers.getContractAt("ERC20", address)
    console.log("balance before", await erc20.balanceOf(owner.address))

    const burn = await erc20.burn(amount)
    const receipt = await burn.wait();
    console.log("Transaction was burn in block number: ", receipt?.blockNumber)
    console.log("balance after", await erc20.balanceOf(owner.address))
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
