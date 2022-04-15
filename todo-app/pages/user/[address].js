import { useRouter } from 'next/router';

export default function addressRouting() {
    const router = useRouter();
    const address = router.query.address;



    function logOut() {
        router.push('/');
    }

    return (
        <div>

            {address}
            <br />
            Hello User
            <button onClick={logOut}>Logout</button>
        </div >
    );

}