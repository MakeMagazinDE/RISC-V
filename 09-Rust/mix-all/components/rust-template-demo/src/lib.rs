#[no_mangle]
extern "C" fn rust_main() -> i32 {
    esp_idf_svc::sys::link_patches();

    esp_idf_svc::log::EspLogger::initialize_default();

    log::info!("Hello, world!");

    use std::arch::asm;

    // Multiply x by 6 using shifts and adds
    let mut x: i32 = 4;
    unsafe {
        asm!(
            "mv   {tmp}, {x}",
            "slli {tmp}, {tmp}, 1",
            "slli {x}, {x}, 2",
            "add  {x}, {x}, {tmp}",
            x = inout(reg) x,
            tmp = out(reg) _,
        );
    }

    // 42
    x
}
