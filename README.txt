This is the C program translated to mips:

 // The function1 is a recursive procedure/function defined by:
//function1(n) = (n / 4) + 17          if n <= 3
//  = (function1(n-2) / 2 ) + function1(n-5)*n - n*n          otherwise


int function1(int n)
{
    if (n <= 3)
    {
        int ans1 = n/4 + 17;
        return ans1;
    }
    else
    {
        int ans1 = function1(n-2)/2 + function1(n-5)*n - n*n ;
        return ans1;
    }
}


// The main calls function1 by entering an integer given by a user.
void main()
{
    int ans, n;
    
    printf("Enter an integer:\n");
    
    // read an integer from user and store it in "n"
    scanf("%d", &n);
    
    ans = function1(n);
    
    // print out the solution computed by function 1
    printf("The solution is: %d\n", ans);
    
    return;
}
 

Sample Output:

Enter an integer:
10
The solution is: 640