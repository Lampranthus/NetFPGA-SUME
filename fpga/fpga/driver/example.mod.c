#include <linux/module.h>
#include <linux/export-internal.h>
#include <linux/compiler.h>

MODULE_INFO(name, KBUILD_MODNAME);

__visible struct module __this_module
__section(".gnu.linkonce.this_module") = {
	.name = KBUILD_MODNAME,
	.init = init_module,
#ifdef CONFIG_MODULE_UNLOAD
	.exit = cleanup_module,
#endif
	.arch = MODULE_ARCH_INIT,
};



static const struct modversion_info ____versions[]
__used __section("__versions") = {
	{ 0x7e2232fb, "ioread32" },
	{ 0xbf9c33b7, "devm_kmalloc" },
	{ 0xfad8f384, "iowrite32" },
	{ 0xf9cd995f, "pci_enable_device_mem" },
	{ 0x42194be5, "pci_alloc_irq_vectors" },
	{ 0xcc6bf4bf, "__pci_register_driver" },
	{ 0x12b313f4, "pci_request_regions" },
	{ 0x5f0cf0e4, "pci_ioremap_bar" },
	{ 0x089fd8b8, "pci_unregister_driver" },
	{ 0xd272d446, "__fentry__" },
	{ 0x011d8503, "pci_read_config_dword" },
	{ 0xd272d446, "__stack_chk_fail" },
	{ 0xc5648699, "pci_free_irq" },
	{ 0x626691f6, "pci_disable_link_state" },
	{ 0x7444c00b, "_dev_info" },
	{ 0x61079369, "print_hex_dump" },
	{ 0x90a48d82, "__ubsan_handle_out_of_bounds" },
	{ 0x9e039c4a, "pci_clear_master" },
	{ 0x7444c00b, "_dev_err" },
	{ 0xa4a71e0b, "pci_request_irq" },
	{ 0x0cac9062, "dma_alloc_attrs" },
	{ 0x8aff9a19, "pci_read_config_word" },
	{ 0x402db74e, "memcmp" },
	{ 0xe5e9eca3, "pci_iounmap" },
	{ 0x7444c00b, "_dev_warn" },
	{ 0x9e039c4a, "pci_set_master" },
	{ 0xd272d446, "__x86_return_thunk" },
	{ 0x058c185a, "jiffies" },
	{ 0x6dfc4e23, "dma_free_attrs" },
	{ 0xf6d149f2, "pci_release_regions" },
	{ 0xcbae5412, "__const_udelay" },
	{ 0x9e039c4a, "pcie_print_link_status" },
	{ 0x9e039c4a, "pci_disable_device" },
	{ 0x89e724a4, "pci_free_irq_vectors" },
	{ 0x67628f51, "msleep" },
	{ 0x70eca2ca, "module_layout" },
};

static const u32 ____version_ext_crcs[]
__used __section("__version_ext_crcs") = {
	0x7e2232fb,
	0xbf9c33b7,
	0xfad8f384,
	0xf9cd995f,
	0x42194be5,
	0xcc6bf4bf,
	0x12b313f4,
	0x5f0cf0e4,
	0x089fd8b8,
	0xd272d446,
	0x011d8503,
	0xd272d446,
	0xc5648699,
	0x626691f6,
	0x7444c00b,
	0x61079369,
	0x90a48d82,
	0x9e039c4a,
	0x7444c00b,
	0xa4a71e0b,
	0x0cac9062,
	0x8aff9a19,
	0x402db74e,
	0xe5e9eca3,
	0x7444c00b,
	0x9e039c4a,
	0xd272d446,
	0x058c185a,
	0x6dfc4e23,
	0xf6d149f2,
	0xcbae5412,
	0x9e039c4a,
	0x9e039c4a,
	0x89e724a4,
	0x67628f51,
	0x70eca2ca,
};
static const char ____version_ext_names[]
__used __section("__version_ext_names") =
	"ioread32\0"
	"devm_kmalloc\0"
	"iowrite32\0"
	"pci_enable_device_mem\0"
	"pci_alloc_irq_vectors\0"
	"__pci_register_driver\0"
	"pci_request_regions\0"
	"pci_ioremap_bar\0"
	"pci_unregister_driver\0"
	"__fentry__\0"
	"pci_read_config_dword\0"
	"__stack_chk_fail\0"
	"pci_free_irq\0"
	"pci_disable_link_state\0"
	"_dev_info\0"
	"print_hex_dump\0"
	"__ubsan_handle_out_of_bounds\0"
	"pci_clear_master\0"
	"_dev_err\0"
	"pci_request_irq\0"
	"dma_alloc_attrs\0"
	"pci_read_config_word\0"
	"memcmp\0"
	"pci_iounmap\0"
	"_dev_warn\0"
	"pci_set_master\0"
	"__x86_return_thunk\0"
	"jiffies\0"
	"dma_free_attrs\0"
	"pci_release_regions\0"
	"__const_udelay\0"
	"pcie_print_link_status\0"
	"pci_disable_device\0"
	"pci_free_irq_vectors\0"
	"msleep\0"
	"module_layout\0"
;

MODULE_INFO(depends, "");

MODULE_ALIAS("pci:v00001234d00000001sv*sd*bc*sc*i*");

MODULE_INFO(srcversion, "5550F219B1699532A04BEB1");
