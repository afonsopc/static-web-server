// use std::{env, net::ToSocketAddrs};
// use warp::Filter;

// #[tokio::main]
// async fn main() {
//     let address = env::var("ADDRESS").unwrap();

//     let static_dir = warp::get().and(warp::fs::dir("/public"));

//     println!("Starting server at {}", address);

//     let address_socket = address.to_socket_addrs().unwrap().next().unwrap();
//     warp::serve(static_dir).run(address_socket).await;
// }

use axum::{extract::Path, routing::get, Router, Server};
use std::{env, net::ToSocketAddrs};

async fn serve_files(path: Option<Path<String>>) -> String {
    let clean_path: String;
    if let Some(path) = path {
        clean_path = path.to_string();
    } else {
        clean_path = "/".to_string();
    }

    "".to_string()
}

#[tokio::main]
async fn main() {
    let address = env::var("ADDRESS").unwrap();
    let address_socket = address.to_socket_addrs().unwrap().next().unwrap();

    let app = Router::new()
        .route("/*path", get(serve_files))
        .route("/", get(serve_files));

    println!("Starting server on: {address}");
    let server = Server::bind(&address_socket).serve(app.into_make_service());

    if let Err(err) = server.await {
        eprintln!("Server error: {err}");
    }
}
