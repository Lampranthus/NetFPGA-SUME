#!/usr/bin/env python3
"""
Versión simplificada para histogramas de timestamps FPGA
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import sys

CLOCK_NS = 6.4

def analisis_simple(archivo_csv):
    # Cargar datos
    df = pd.read_csv(archivo_csv)
    
    # Calcular diferencias
    df['intra_ciclos'] = df['end'] - df['start']
    df['intra_ns'] = df['intra_ciclos'] * CLOCK_NS
    
    df['inter_start_ciclos'] = df['start'].diff()
    df['inter_start_ns'] = df['inter_start_ciclos'] * CLOCK_NS
    
    df['end_to_next_ciclos'] = df['start'].shift(-1) - df['end']
    df['end_to_next_ns'] = df['end_to_next_ciclos'] * CLOCK_NS
    
    # Crear 3 histogramas
    fig, axes = plt.subplots(3, 1, figsize=(10, 12))
    
    # 1. Intra-paquete
    axes[0].hist(df['intra_ns'].dropna(), bins=30, alpha=0.7, color='blue')
    axes[0].set_title('1. Diferencia Intra-paquete (end - start)\nProcesamiento interno del paquete')
    axes[0].set_xlabel('Tiempo (ns)')
    axes[0].set_ylabel('Frecuencia')
    axes[0].grid(True, alpha=0.3)
    
    # 2. Inter-paquete (start a start)
    axes[1].hist(df['inter_start_ns'].dropna().iloc[1:], bins=30, alpha=0.7, color='green')
    axes[1].set_title('2. Diferencia Inter-paquete (start actual - start anterior)\nIntervalo entre paquetes')
    axes[1].set_xlabel('Tiempo (ns)')
    axes[1].set_ylabel('Frecuencia')
    axes[1].grid(True, alpha=0.3)
    
    # 3. End a next start
    axes[2].hist(df['end_to_next_ns'].dropna().iloc[:-1], bins=30, alpha=0.7, color='red')
    axes[2].set_title('3. Diferencia End actual - Start siguiente\nGap entre fin y próximo inicio')
    axes[2].set_xlabel('Tiempo (ns)')
    axes[2].set_ylabel('Frecuencia')
    axes[2].grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('histogramas_timestamps.png', dpi=150, bbox_inches='tight')
    plt.show()
    
    # Estadísticas
    print("=" * 50)
    print("ESTADÍSTICAS:")
    print("=" * 50)
    
    print("\n1. Intra-paquete (end - start):")
    intra = df['intra_ns']
    print(f"   Media: {intra.mean():.1f} ns ({intra.mean()/1000:.3f} µs)")
    print(f"   Std:   {intra.std():.1f} ns")
    print(f"   Min:   {intra.min():.1f} ns")
    print(f"   Max:   {intra.max():.1f} ns")
    
    print("\n2. Inter-paquete (start - start anterior):")
    inter = df['inter_start_ns'].iloc[1:]
    print(f"   Media: {inter.mean():.1f} ns ({inter.mean()/1000:.3f} µs)")
    print(f"   Std:   {inter.std():.1f} ns (jitter)")
    print(f"   Min:   {inter.min():.1f} ns")
    print(f"   Max:   {inter.max():.1f} ns")
    
    print("\n3. End actual - Start siguiente:")
    end_next = df['end_to_next_ns'].iloc[:-1]
    print(f"   Media: {end_next.mean():.1f} ns ({end_next.mean()/1000:.3f} µs)")
    print(f"   Std:   {end_next.std():.1f} ns")
    print(f"   Min:   {end_next.min():.1f} ns")
    print(f"   Max:   {end_next.max():.1f} ns")
    
    print("\n✓ Gráfico guardado: histogramas_timestamps.png")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Uso: python3 analisis_simple.py archivo.csv")
        sys.exit(1)
    
    analisis_simple(sys.argv[1])