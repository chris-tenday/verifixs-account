var domain="http://127.0.0.1/edge_verified-backend";
if(location.href.includes(".com"))
{
    if(location.protocol!="https:")
    {
        location.protocol="https:";
    }

    if(location.href.includes("verifixs.com"))
    {
        domain="https://back-system.verifixs.com"; /** live server */
    }
}
domain="https://back-system.verifixs.com";


const states = {
    baseURL: domain,
    diligences: [],
    diligenceDetails: {},
    client: {},
    actifs: [],
    diligenceTypes: []
};

export default states;
