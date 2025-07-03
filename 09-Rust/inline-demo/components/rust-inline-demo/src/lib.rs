#[no_mangle]
extern "C" fn multiply6(n: i32) -> i32 {
    esp_idf_svc::sys::link_patches();

    use std::arch::asm;

    let mut x: i32 = n;
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

    x
}
