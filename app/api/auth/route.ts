

export async function GET(request: Request) {
console.log('Request body:', request.body)
return new Response('Hello, world!')
}