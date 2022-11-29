export default
{
    save:function(key,data)
    {
        var d=JSON.stringify(data);
        if(d!==undefined && d!==null)
        {
            localStorage.setItem(key,d);
        }
    },
    get:function(key)
    {
        var d=localStorage.getItem(key);
        if(d===undefined || d===null)
        {
            return null;
        }

        return JSON.parse(d);
    },
    delete:function(key)
    {
        localStorage.removeItem(key);
    }

};
