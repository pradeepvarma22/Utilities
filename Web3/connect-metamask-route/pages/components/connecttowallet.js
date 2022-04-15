const { ethers } = require('ethers');
import React, { useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/router';


export default function connecttowallet() {

    const [walletAddress, setWalletAddress] = useState('');
    const [provider, setProvider] = useState({});
    const [signer, setSigner] = useState({});
    const router = useRouter();


    async function connectToWallet(event) {

        if (window.ethereum) {

            //connecting to wallet and using wallet provider without using infura
            //provider is web3 provider
            const provider_t = new ethers.providers.Web3Provider(window.ethereum);
            const allWalletAccounts = await window.ethereum.request({ method: 'eth_requestAccounts' });

            //signer is json rpc signer
            const signer_t = provider_t.getSigner();

            //Array of wallet address
            //selecting first wallet address
            setWalletAddress(allWalletAccounts[0]);
            //here use state walletaddress wont work until connectToWallet finish 
            console.log(walletAddress);     //Wont work
            setProvider(provider_t);
            setSigner(signer_t);
            document.getElementById('connect-wallet-button').setAttribute('hidden', '');
            document.getElementById('wallet-address').innerHTML = allWalletAccounts[0];
            //stop page reload
            event.preventDefault();
            router.push(`/user/${allWalletAccounts[0]}`);

        }
        else {
            // document.getElementById('error').innerHTML = 'install metamask wallet';
        }
    }

    return (
        <div>

            <button id="connect-wallet-button" onClick={connectToWallet}>Connect to Wallet</button>
            <p id="wallet-address"></p>
            {/* <Link href={'/user/[address]'} as={`/user/${walletAddress}`}>Go to UserPage</Link> */}
        </div>
    )


}