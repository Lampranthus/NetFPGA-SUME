#!/usr/bin/env python3
"""
Gráfica: Start Actual → Start Siguiente vs Tamaño de Payload
Con escala logarítmica en ambos ejes
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import glob
import re

CLOCK_NS = 6.4  # 1 ciclo = 6.4 ns

def grafica_start_start():
    # Buscar archivos CSV
    archivos = sorted(glob.glob("*.csv"))
    
    if not archivos:
        print("No se encontraron archivos CSV")
        return
    
    print("Analizando archivos...")
    
    # Listas para almacenar resultados
    tamanos = []
    medias = []
    stds = []
    nombres = []
    
    for archivo in archivos:
        try:
            # Extraer tamaño del nombre
            match = re.search(r'(\d+)\.csv$', archivo)
            if not match:
                continue
            
            tamano = int(match.group(1))
            df = pd.read_csv(archivo)
            
            # Calcular diferencia start actual → start siguiente
            diferencias = (df['start'].shift(-1) - df['start']) * CLOCK_NS
            diferencias = diferencias.dropna()
            
            if len(diferencias) > 0:
                media = diferencias.mean()
                std = diferencias.std()
                
                tamanos.append(tamano)
                medias.append(media)
                stds.append(std)
                nombres.append(f"{tamano} bytes")
                
                print(f"{tamano:4d} bytes: {media:7.1f} ± {std:5.1f} ns")
                
        except Exception as e:
            print(f"Error en {archivo}: {e}")
            continue
    
    if not tamanos:
        print("No se pudieron procesar los datos")
        return
    
    # Ordenar por tamaño
    datos = sorted(zip(tamanos, medias, stds, nombres))
    tamanos, medias, stds, nombres = zip(*datos)
    
    # Crear gráfica
    plt.figure(figsize=(10, 8))
    
    # Gráfico de puntos con barras de error
    plt.errorbar(tamanos, medias, yerr=stds, fmt='o-', 
                 linewidth=2, markersize=10, capsize=5, capthick=2,
                 color='darkblue', alpha=0.8, ecolor='red', elinewidth=1.5)
    
    # Etiquetar cada punto
    for tam, media, std, nombre in zip(tamanos, medias, stds, nombres):
        plt.annotate(f'{media:.0f}±{std:.0f} ns', 
                    xy=(tam, media), 
                    xytext=(0, 10), 
                    textcoords='offset points',
                    ha='center', va='bottom',
                    fontsize=9, fontweight='bold',
                    bbox=dict(boxstyle='round,pad=0.3', facecolor='yellow', alpha=0.7))
    
    # Configurar escalas logarítmicas
    plt.xscale('log', base=2)
    plt.yscale('log', base=10)
    
    # Configurar ejes
    plt.xlabel('Tamaño de Payload UDP (bytes)', fontsize=12, fontweight='bold')
    plt.ylabel('Intervalo Start→Start (ns)', fontsize=12, fontweight='bold')
    plt.title('Intervalo entre Inicios de Paquetes Consecutivos\nvs Tamaño de Payload (escala log-log)', 
             fontsize=14, fontweight='bold', pad=20)
    
    # Configurar ticks del eje X
    plt.xticks(tamanos, [str(t) for t in tamanos], rotation=45, fontsize=10)
    
    # Configurar ticks del eje Y
    from matplotlib.ticker import ScalarFormatter
    plt.gca().yaxis.set_major_formatter(ScalarFormatter())
    plt.gca().yaxis.set_minor_formatter(ScalarFormatter())
    plt.ticklabel_format(style='plain', axis='y')
    
    # Grid
    plt.grid(True, which='both', alpha=0.3)
    plt.grid(True, which='minor', alpha=0.1, linestyle='--')
    
    # Ajustar límites
    plt.xlim(min(tamanos)*0.8, max(tamanos)*1.2)
    plt.ylim(min(medias)*0.8, max(medias)*1.2)
    
    # Añadir línea de tendencia lineal (en escala log-log)
    if len(tamanos) > 1:
        # Regresión lineal en escala logarítmica
        log_tamanos = np.log2(tamanos)
        log_medias = np.log10(medias)
        
        coeffs = np.polyfit(log_tamanos, log_medias, 1)
        poly = np.poly1d(coeffs)
        
        # Crear puntos para la línea de tendencia
        x_fit = np.linspace(min(log_tamanos), max(log_tamanos), 100)
        y_fit = poly(x_fit)
        
        # Convertir de vuelta a escala normal para graficar
        x_plot = 2**x_fit
        y_plot = 10**y_fit
        
        plt.plot(x_plot, y_plot, 'r--', linewidth=2, alpha=0.7,
                label=f'Tendencia: y ∝ x^{coeffs[0]:.2f}')
        
        # Añadir ecuación
        eq_text = f'y = 10^{coeffs[1]:.2f} × x^{coeffs[0]:.2f}'
        plt.text(0.05, 0.95, eq_text, transform=plt.gca().transAxes,
                fontsize=11, verticalalignment='top',
                bbox=dict(boxstyle='round', facecolor='white', alpha=0.8))
    
    # Leyenda
    plt.legend(loc='upper left', fontsize=10)
    
    # Información adicional
    info_text = f'Total: {len(tamanos)} puntos\nClock FPGA: {CLOCK_NS} ns/ciclo'
    plt.text(0.05, 0.05, info_text, transform=plt.gca().transAxes,
            fontsize=10, verticalalignment='bottom',
            bbox=dict(boxstyle='round', facecolor='lightgray', alpha=0.8))
    
    # Ajustar layout
    plt.tight_layout()
    
    # Guardar
    plt.savefig('intervalo_start_start_log.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    print(f"\n✓ Gráfica guardada: intervalo_start_start_log.png")
    
    # Mostrar tabla de resultados
    print("\n" + "="*50)
    print("RESUMEN DE RESULTADOS:")
    print("="*50)
    print(f"{'Tamaño (bytes)':<15} {'Media (ns)':<12} {'Std (ns)':<12} {'Paquetes/seg':<12}")
    print("-"*50)
    
    for tam, media, std in zip(tamanos, medias, stds):
        if media > 0:
            pps = 1e9 / media  # Paquetes por segundo
            print(f"{tam:<15} {media:<12.1f} {std:<12.1f} {pps:<12.0f}")
    
    print("="*50)

if __name__ == "__main__":
    grafica_start_start()